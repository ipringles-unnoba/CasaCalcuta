<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Familia;
use App\Models\Integrante;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class IntegranteController extends Controller
{
    use CrudController;

    private const VIEW_PERMISSIONS = ['Ver familias', 'Gestionar familias'];

    private const MANAGE_PERMISSION = ['Gestionar familias'];

    protected function modelClass(): string
    {
        return Integrante::class;
    }

    protected function relations(): array
    {
        return ['familia'];
    }

    protected function storeRules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255'],
            'apellido' => ['required', 'string', 'max:255'],
            'fecha_nacimiento' => ['required', 'date'],
            'tipo_documento' => ['required', 'string', 'max:255'],
            'numero_documento' => ['required', 'string', 'max:255', Rule::unique('integrantes', 'numero_documento')],
            'referente' => ['required', 'boolean'],
            'familia_id' => ['required', 'integer', 'exists:familias,id_familia'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'nombre' => ['sometimes', 'required', 'string', 'max:255'],
            'apellido' => ['sometimes', 'required', 'string', 'max:255'],
            'fecha_nacimiento' => ['sometimes', 'required', 'date'],
            'tipo_documento' => ['sometimes', 'required', 'string', 'max:255'],
            'numero_documento' => ['sometimes', 'required', 'string', 'max:255', Rule::unique('integrantes', 'numero_documento')->ignore($record->getKey(), 'id_integrante')],
            'referente' => ['sometimes', 'required', 'boolean'],
            'familia_id' => ['sometimes', 'required', 'integer', 'exists:familias,id_familia'],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions($request, self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        $data = $request->validate($this->storeRules());

        $integrante = DB::transaction(function () use ($data): Integrante {
            $integrante = Integrante::query()->create($data);
            $this->syncFamiliaReferente($integrante, null);

            return $integrante;
        });

        return response()->json($integrante->load($this->relations()), 201);
    }

    public function show(Integrante $integrante): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return $this->showRecord($integrante);
    }

    public function update(Request $request, Integrante $integrante): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        $data = $request->validate($this->updateRules($integrante));
        $originalFamiliaId = $integrante->familia_id;

        DB::transaction(function () use ($integrante, $data, $originalFamiliaId): void {
            $integrante->fill($data);
            $integrante->save();

            $this->syncFamiliaReferente($integrante, $originalFamiliaId);
        });

        return response()->json($integrante->load($this->relations()));
    }

    public function destroy(Integrante $integrante): JsonResponse|Response
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        DB::transaction(function () use ($integrante): void {
            $integrante->delete();
        });

        return response()->noContent();
    }

    public function documentos(Integrante $integrante): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($integrante->documentos()->latest('id_documento')->get());
    }

    public function participacionesComision(Integrante $integrante): JsonResponse
    {
        if ($response = $this->authorizeFamilyPermissions(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($integrante->participacionesComision()->latest('id_participacion_comision')->get());
    }

    protected function syncFamiliaReferente(Integrante $integrante, ?int $originalFamiliaId): void
    {
        $familia = $integrante->familia()->with('referente')->first();

        if ($originalFamiliaId && $familia && $familia->getKey() !== $originalFamiliaId) {
            $originalFamilia = Familia::query()->with('referente')->find($originalFamiliaId);

            if ($originalFamilia && $originalFamilia->referente && $originalFamilia->referente->getKey() === $integrante->getKey()) {
                $originalFamilia->forceFill(['referente_id' => null])->save();
            }
        }

        if (! $familia) {
            return;
        }

        if ($integrante->referente) {
            if ($familia->referente && $familia->referente->getKey() !== $integrante->getKey()) {
                $familia->referente->forceFill(['referente' => false])->save();
            }

            $familia->forceFill(['referente_id' => $integrante->getKey()])->save();
            return;
        }

        if ($familia->referente && $familia->referente->getKey() === $integrante->getKey()) {
            $familia->forceFill(['referente_id' => null])->save();
        }
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
