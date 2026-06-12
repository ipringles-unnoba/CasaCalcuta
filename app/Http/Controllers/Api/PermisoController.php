<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Permiso;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;

class PermisoController extends Controller
{
    use CrudController;

    private const MANAGE_PERMISSION = ['Gestionar permisos'];

    protected function modelClass(): string
    {
        return Permiso::class;
    }

    protected function relations(): array
    {
        return ['roles'];
    }

    protected function storeRules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255', 'unique:permisos,nombre'],
            'modulo' => ['required', 'string', 'max:255'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'nombre' => ['sometimes', 'required', 'string', 'max:255', Rule::unique('permisos', 'nombre')->ignore($record->getKey(), $record->getKeyName())],
            'modulo' => ['sometimes', 'required', 'string', 'max:255'],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        if ($response = $this->authorizePermissionManagement($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        if ($response = $this->authorizePermissionManagement($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->storeRecord($request);
    }

    public function show(Permiso $permiso): JsonResponse
    {
        if ($response = $this->authorizePermissionManagement(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->showRecord($permiso);
    }

    public function update(Request $request, Permiso $permiso): JsonResponse
    {
        if ($response = $this->authorizePermissionManagement($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->updateRecord($request, $permiso);
    }

    public function destroy(Permiso $permiso): JsonResponse|Response
    {
        if ($response = $this->authorizePermissionManagement(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->destroyRecord($permiso);
    }

    private function authorizePermissionManagement(Request $request, array $requiredPermissions): ?JsonResponse
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
