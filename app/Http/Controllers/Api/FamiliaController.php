<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Api\Concerns\AuthenticatedRegistrar;
use App\Http\Controllers\Controller;
use App\Models\Integrante;
use App\Models\Familia;
use App\Services\PriorizacionSocialService;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class FamiliaController extends Controller
{
    use AuthenticatedRegistrar, CrudController;

    private const VIEW_PERMISSIONS = ['Ver familias', 'Gestionar familias'];

    private const MANAGE_PERMISSION = ['Gestionar familias'];

    private const LIST_PERMISSION = ['Gestionar listas'];

    protected function modelClass(): string
    {
        return Familia::class;
    }

    protected function relations(): array
    {
        return ['registradoPor', 'referente', 'evaluadoPor'];
    }

    protected function storeRules(): array
    {
        return [
            'direccion' => ['required', 'string', 'max:255'],
            'telefono' => ['required', 'string', 'max:50'],
            'puntaje_prioridad' => ['sometimes', 'nullable', 'integer', 'min:0'],
            'prioridad_social' => ['sometimes', 'nullable', 'string', 'max:255'],
            'estado_lista' => ['required', 'string', 'max:255'],
            'fecha_ingreso' => ['required', 'date'],
            'activa' => ['required', 'boolean'],
            'registrado_por' => ['sometimes', 'integer', 'exists:usuarios,id_usuario'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'direccion' => ['sometimes', 'required', 'string', 'max:255'],
            'telefono' => ['sometimes', 'required', 'string', 'max:50'],
            'puntaje_prioridad' => ['sometimes', 'nullable', 'integer', 'min:0'],
            'prioridad_social' => ['sometimes', 'nullable', 'string', 'max:255'],
            'estado_lista' => ['sometimes', 'required', 'string', 'max:255'],
            'fecha_ingreso' => ['sometimes', 'required', 'date'],
            'activa' => ['sometimes', 'required', 'boolean'],
            'registrado_por' => ['sometimes', 'integer', 'exists:usuarios,id_usuario'],
            'referente_id' => [
                'sometimes',
                'nullable',
                'integer',
                Rule::exists('integrantes', 'id_integrante')->where('familia_id', $record->getKey()),
            ],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions($request, self::VIEW_PERMISSIONS)) {
            return $response;
        }

        $query = Familia::query()->with($this->relations())->latest($this->orderBy());

        if ($request->filled('prioridad_social')) {
            $query->where('prioridad_social', $request->input('prioridad_social'));
        }

        if ($request->filled('estado_lista')) {
            $query->where('estado_lista', $request->input('estado_lista'));
        }

        if ($request->filled('activa')) {
            $query->where('activa', $request->boolean('activa'));
        }

        if ($request->filled('evaluada')) {
            $evaluada = $request->boolean('evaluada');
            $evaluada ? $query->whereNotNull('evaluado_por') : $query->whereNull('evaluado_por');
        }

        if ($request->filled('sort_by')) {
            $sortBy = $request->input('sort_by');
            $sortOrder = $request->input('sort_order', 'desc');

            if (in_array($sortBy, ['puntaje_prioridad', 'prioridad_social', 'fecha_ingreso', 'direccion'])) {
                $query->reorder($sortBy, $sortOrder === 'asc' ? 'asc' : 'desc');
            }
        }

        return response()->json($query->paginate((int) $request->integer('per_page', 15)));
    }

    public function store(Request $request): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        $data = $request->validate($this->storeRules());
        $data = $this->applyAuthenticatedRegistrar($request, $data);

        if ($data instanceof JsonResponse) {
            return $data;
        }

        $familia = Familia::query()->create($data);

        return response()->json($familia->load($this->relations()), 201);
    }

    public function show(Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return $this->showRecord($familia);
    }

    public function update(Request $request, Familia $familia): JsonResponse
    {
        $validated = $request->validate($this->updateRules($familia));
        $validated = $this->applyAuthenticatedRegistrar($request, $validated);

        if ($validated instanceof JsonResponse) {
            return $validated;
        }

        if (array_key_exists('estado_lista', $validated)) {
            if ($response = $this->authorizeFamilyPermissions($request, self::LIST_PERMISSION)) {
                return $response;
            }
        }

        $otherFields = array_diff_key($validated, array_flip(['estado_lista']));

        if ($otherFields !== [] && $response = $this->authorizeFamilyPermissions($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        $familia->fill($validated);
        $familia->save();

        return response()->json($familia->load($this->relations()));
    }

    public function destroy(Familia $familia): JsonResponse|Response
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->destroyRecord($familia);
    }

    public function integrantes(Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($familia->integrantes()->latest('id_integrante')->get());
    }

    public function donaciones(Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($familia->donaciones()->latest('id_donacion')->get());
    }

    public function pedidosEspeciales(Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($familia->pedidosEspeciales()->latest('id_pedido_especial')->get());
    }

    public function visitasDomiciliarias(Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($familia->visitasDomiciliarias()->latest('id_visita_domiciliaria')->get());
    }

    public function registrosAsistencia(Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($familia->registrosAsistencia()->latest('id_registro_asistencia')->get());
    }

    public function referente(Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($familia->load('referente')->referente);
    }

    public function syncReferente(Request $request, Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        $data = $request->validate([
            'integrante_id' => [
                'required',
                'integer',
                Rule::exists('integrantes', 'id_integrante')->where('familia_id', $familia->id_familia),
            ],
        ]);

        $integrante = $familia->integrantes()->whereKey($data['integrante_id'])->firstOrFail();

        DB::transaction(function () use ($familia, $integrante): void {
            $familia->loadMissing('referente');

            if ($familia->referente && $familia->referente->getKey() !== $integrante->getKey()) {
                $familia->referente->forceFill(['referente' => false])->save();
            }

            $integrante->forceFill(['referente' => true])->save();
            $familia->forceFill(['referente_id' => $integrante->getKey()])->save();
        });

        return response()->json($familia->fresh(['registradoPor', 'referente']));
    }

    public function clearReferente(Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        DB::transaction(function () use ($familia): void {
            $familia->loadMissing('referente');

            if ($familia->referente) {
                $familia->referente->forceFill(['referente' => false])->save();
            }

            $familia->forceFill(['referente_id' => null])->save();
        });

        return response()->json($familia->fresh(['registradoPor', 'referente']));
    }

    public function evaluarPrioridad(Request $request, Familia $familia): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        $data = $request->validate([
            'puntaje_menores' => ['required', 'integer', 'in:0,1,2'],
            'puntaje_alimentacion' => ['required', 'integer', 'in:0,2,3'],
            'puntaje_asistencia' => ['required', 'integer', 'in:0,1,2'],
            'puntaje_participacion' => ['required', 'integer', 'in:0,1,2'],
        ]);

        $service = app(PriorizacionSocialService::class);

        $familia = $service->evaluar($familia, $data, $request->user());

        return response()->json($familia);
    }

    private function authorizeFamilyPermissions(Request $request, array $requiredPermissions): ?JsonResponse
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
}
