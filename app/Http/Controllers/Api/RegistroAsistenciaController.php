<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Api\Concerns\AuthenticatedRegistrar;
use App\Http\Controllers\Controller;
use App\Models\Familia;
use App\Models\Notificacion;
use App\Models\Usuario;
use App\Models\RegistroAsistencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Carbon;

class RegistroAsistenciaController extends Controller
{
    use AuthenticatedRegistrar, CrudController;

    private const MANAGE_PERMISSION = ['Poner asistencia'];

    private const ALERT_PERMISSION = 'Alerta Ausentismo';

    private const ABSENCE_STATE = 'ausente';

    protected function modelClass(): string
    {
        return RegistroAsistencia::class;
    }

    protected function relations(): array
    {
        return ['familia', 'registradoPor'];
    }

    protected function storeRules(): array
    {
        return [
            'familia_id' => ['required', 'integer', 'exists:familias,id_familia'],
            'fecha' => ['required', 'date'],
            'estado' => ['required', 'string', 'max:255'],
            'registrado_por' => ['sometimes', 'integer', 'exists:usuarios,id_usuario'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'familia_id' => ['sometimes', 'required', 'integer', 'exists:familias,id_familia'],
            'fecha' => ['sometimes', 'required', 'date'],
            'estado' => ['sometimes', 'required', 'string', 'max:255'],
            'registrado_por' => ['sometimes', 'integer', 'exists:usuarios,id_usuario'],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        if ($response = $this->authorizeAttendancePermissions($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        return DB::transaction(function () use ($request): JsonResponse {
            $data = $request->validate($this->storeRules());
            $data = $this->applyAuthenticatedRegistrar($request, $data);
            if ($data instanceof JsonResponse) {
                return $data;
            }

            $familyId = (int) $data['familia_id'];
            if ($response = $this->rejectDuplicateAttendance($familyId, (string) $data['fecha'])) {
                return $response;
            }

            $beforeStreak = $this->currentAbsenceStreak($familyId);

            $registroAsistencia = RegistroAsistencia::query()->create($data);
            $afterStreak = $this->currentAbsenceStreak($familyId);

            $this->maybeCreateAusentismoCriticoNotification($familyId, $beforeStreak, $afterStreak);

            return response()->json($registroAsistencia->load($this->relations()), 201);
        });
    }

    public function show(RegistroAsistencia $registroAsistencia): JsonResponse
    {
        return $this->showRecord($registroAsistencia);
    }

    public function update(Request $request, RegistroAsistencia $registroAsistencia): JsonResponse
    {
        if ($response = $this->authorizeAttendancePermissions($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        return DB::transaction(function () use ($request, $registroAsistencia): JsonResponse {
            $originalFamilyId = (int) $registroAsistencia->familia_id;
            $validated = $request->validate($this->updateRules($registroAsistencia));
            $validated = $this->applyAuthenticatedRegistrar($request, $validated);
            if ($validated instanceof JsonResponse) {
                return $validated;
            }

            $targetFamilyId = (int) ($validated['familia_id'] ?? $originalFamilyId);
            $targetFecha = (string) ($validated['fecha'] ?? $registroAsistencia->fecha?->toDateString() ?? (string) $registroAsistencia->fecha);

            if ($response = $this->rejectDuplicateAttendance($targetFamilyId, $targetFecha, $registroAsistencia->getKey())) {
                return $response;
            }

            $beforeStreaks = [
                $originalFamilyId => $this->currentAbsenceStreak($originalFamilyId),
            ];

            if ($targetFamilyId !== $originalFamilyId) {
                $beforeStreaks[$targetFamilyId] = $this->currentAbsenceStreak($targetFamilyId);
            }

            $registroAsistencia->fill($validated);
            $registroAsistencia->save();
            $afterStreaks = [
                $targetFamilyId => $this->currentAbsenceStreak($targetFamilyId),
            ];

            if ($originalFamilyId !== $targetFamilyId) {
                $afterStreaks[$originalFamilyId] = $this->currentAbsenceStreak($originalFamilyId);
            }

            $this->maybeCreateAusentismoCriticoNotification($originalFamilyId, $beforeStreaks[$originalFamilyId], $afterStreaks[$originalFamilyId]);

            if ($targetFamilyId !== $originalFamilyId) {
                $this->maybeCreateAusentismoCriticoNotification($targetFamilyId, $beforeStreaks[$targetFamilyId], $afterStreaks[$targetFamilyId]);
            }

            return response()->json($registroAsistencia->load($this->relations()));
        });
    }

    public function destroy(RegistroAsistencia $registroAsistencia): JsonResponse|Response
    {
        if ($response = $this->authorizeAttendancePermissions(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        return DB::transaction(function () use ($registroAsistencia): Response {
            $familyId = (int) $registroAsistencia->familia_id;
            $beforeStreak = $this->currentAbsenceStreak($familyId);

            $registroAsistencia->delete();
            $afterStreak = $this->currentAbsenceStreak($familyId);

            $this->maybeCreateAusentismoCriticoNotification($familyId, $beforeStreak, $afterStreak);

            return response()->noContent();
        });
    }

    private function authorizeAttendancePermissions(Request $request, array $requiredPermissions): ?JsonResponse
    {
        $usuario = $request->user();

        if ($usuario === null) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        $usuario->loadMissing('rol.permisos');
        $permissions = $usuario->rol?->permisos ?? collect();
        $requiredPermissions = array_map('mb_strtolower', $requiredPermissions);

        foreach ($permissions as $permiso) {
            if (in_array(mb_strtolower($permiso->nombre), $requiredPermissions, true)) {
                return null;
            }
        }

        return response()->json(['message' => 'Acceso no autorizado. Falta el permiso: ' . implode(' o ', $requiredPermissions) . '.'], 403);
    }

    private function currentAbsenceStreak(int $familyId): array
    {
        $count = 0;
        $startDate = null;

        foreach (RegistroAsistencia::query()
            ->where('familia_id', $familyId)
            ->orderByDesc('fecha')
            ->orderByDesc('id_registro_asistencia')
            ->get() as $registroAsistencia) {
            if (mb_strtolower($registroAsistencia->estado) !== self::ABSENCE_STATE) {
                break;
            }

            $count++;
            $startDate = $registroAsistencia->fecha instanceof Carbon
                ? $registroAsistencia->fecha->toDateString()
                : (string) $registroAsistencia->fecha;
        }

        return [
            'count' => $count,
            'start_date' => $startDate,
        ];
    }

    private function rejectDuplicateAttendance(int $familyId, string $fecha, ?int $ignoreId = null): ?JsonResponse
    {
        $query = RegistroAsistencia::query()
            ->where('familia_id', $familyId)
            ->whereDate('fecha', $fecha);

        if ($ignoreId !== null) {
            $query->where('id_registro_asistencia', '!=', $ignoreId);
        }

        if (! $query->exists()) {
            return null;
        }

        return response()->json([
            'message' => 'Ya existe un registro de asistencia para esa familia en esa fecha.',
        ], 422);
    }

    private function maybeCreateAusentismoCriticoNotification(int $familyId, array $beforeStreak, array $afterStreak): void
    {
        $threshold = $this->ausentismoCriticoThreshold();
        $afterCount = (int) ($afterStreak['count'] ?? 0);
        $beforeCount = (int) ($beforeStreak['count'] ?? 0);

        if ($afterCount < $threshold || $afterCount <= $beforeCount) {
            return;
        }

        $receptores = Usuario::query()
            ->whereHas('rol.permisos', function ($query): void {
                $query->where('nombre', self::ALERT_PERMISSION);
            })
            ->get();

        if ($receptores->isEmpty()) {
            return;
        }

        $familia = Familia::query()->with('referente')->find($familyId);
        if ($familia === null) {
            return;
        }

        $referente = trim((string) (($familia->referente?->nombre ?? '') . ' ' . ($familia->referente?->apellido ?? '')));
        if ($referente === '') {
            $referente = 'referente';
        }

        if (mb_strtoupper((string) $familia->estado_lista) !== 'PRINCIPAL') {
            return;
        }

        $notificacion = Notificacion::query()->create([
            'fecha' => now()->toDateString(),
            'motivo' => 'La familia de ' . $referente . ' está mostrando Ausentismo critico. Se propone bajarla de la lista principal.',
        ]);

        $notificacion->usuarios()->sync($receptores->pluck('id_usuario')->all());
    }

    private function ausentismoCriticoThreshold(): int
    {
        return max(1, (int) env('AUSENTISMO_CRITICO', 3));
    }
}
