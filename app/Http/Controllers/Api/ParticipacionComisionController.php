<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\ParticipacionComision;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class ParticipacionComisionController extends Controller
{
    use CrudController;

    private const VIEW_PERMISSIONS = ['Ver comisiones', 'Gestionar comisiones', 'Gestionar participaciones'];

    private const MANAGE_PERMISSION = ['Gestionar participaciones'];

    protected function modelClass(): string
    {
        return ParticipacionComision::class;
    }

    protected function relations(): array
    {
        return ['integrante', 'comision'];
    }

    protected function storeRules(): array
    {
        return [
            'fecha_inicio' => ['required', 'date'],
            'estado' => ['required', 'string', 'in:activo,inactivo,ocasional'],
            'observaciones' => ['nullable', 'string', 'max:255'],
            'integrante_id' => ['required', 'integer', 'exists:integrantes,id_integrante'],
            'comision_id' => ['required', 'integer', 'exists:comisiones,id_comision'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'fecha_inicio' => ['sometimes', 'required', 'date'],
            'estado' => ['sometimes', 'required', 'string', 'in:activo,inactivo,ocasional'],
            'observaciones' => ['nullable', 'string', 'max:255'],
            'integrante_id' => ['sometimes', 'required', 'integer', 'exists:integrantes,id_integrante'],
            'comision_id' => ['sometimes', 'required', 'integer', 'exists:comisiones,id_comision'],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        if ($response = $this->authorizePermission($request, self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        if ($response = $this->authorizePermission($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        $data = $request->validate($this->storeRules());

        $participacionComision = ParticipacionComision::query()->updateOrCreate(
            [
                'integrante_id' => $data['integrante_id'],
                'comision_id' => $data['comision_id'],
            ],
            $data
        );

        return response()->json(
            $participacionComision->load($this->relations()),
            $participacionComision->wasRecentlyCreated ? 201 : 200
        );
    }

    public function show(ParticipacionComision $participacionComision): JsonResponse
    {
        if ($response = $this->authorizePermission(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return $this->showRecord($participacionComision);
    }

    public function update(Request $request, ParticipacionComision $participacionComision): JsonResponse
    {
        if ($response = $this->authorizePermission($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->updateRecord($request, $participacionComision);
    }

    public function destroy(ParticipacionComision $participacionComision): Response
    {
        if ($response = $this->authorizePermission(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->destroyRecord($participacionComision);
    }

    private function authorizePermission(Request $request, array $requiredPermissions): ?JsonResponse
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
