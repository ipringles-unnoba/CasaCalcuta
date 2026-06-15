<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Comision;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class ComisionController extends Controller
{
    use CrudController;

    private const VIEW_PERMISSIONS = ['Ver comisiones', 'Gestionar comisiones'];

    private const MANAGE_PERMISSION = ['Gestionar comisiones'];

    protected function modelClass(): string
    {
        return Comision::class;
    }

    protected function relations(): array
    {
        return ['encargado'];
    }

    protected function storeRules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255'],
            'activa' => ['required', 'boolean'],
            'descripcion' => ['required', 'string', 'max:255'],
            'encargado' => ['required', 'integer', 'exists:usuarios,id_usuario'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'nombre' => ['sometimes', 'required', 'string', 'max:255'],
            'activa' => ['sometimes', 'required', 'boolean'],
            'descripcion' => ['sometimes', 'required', 'string', 'max:255'],
            'encargado' => ['sometimes', 'required', 'integer', 'exists:usuarios,id_usuario'],
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

        return $this->storeRecord($request);
    }

    public function show(Comision $comision): JsonResponse
    {
        if ($response = $this->authorizePermission(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return $this->showRecord($comision);
    }

    public function update(Request $request, Comision $comision): JsonResponse
    {
        if ($response = $this->authorizePermission($request, self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->updateRecord($request, $comision);
    }

    public function destroy(Comision $comision): Response
    {
        if ($response = $this->authorizePermission(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->destroyRecord($comision);
    }

    public function participaciones(Comision $comision): JsonResponse
    {
        if ($response = $this->authorizePermission(request(), self::VIEW_PERMISSIONS)) {
            return $response;
        }

        return response()->json($comision->participaciones()->latest('id_participacion_comision')->get());
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
