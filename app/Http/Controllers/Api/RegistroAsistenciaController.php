<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\RegistroAsistencia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class RegistroAsistenciaController extends Controller
{
    use CrudController;

    private const MANAGE_PERMISSION = ['Poner asistencia'];

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
            'registrado_por' => ['required', 'integer', 'exists:usuarios,id_usuario'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'familia_id' => ['sometimes', 'required', 'integer', 'exists:familias,id_familia'],
            'fecha' => ['sometimes', 'required', 'date'],
            'estado' => ['sometimes', 'required', 'string', 'max:255'],
            'registrado_por' => ['sometimes', 'required', 'integer', 'exists:usuarios,id_usuario'],
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

        return $this->storeRecord($request);
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

        return $this->updateRecord($request, $registroAsistencia);
    }

    public function destroy(RegistroAsistencia $registroAsistencia): JsonResponse|Response
    {
        if ($response = $this->authorizeAttendancePermissions(request(), self::MANAGE_PERMISSION)) {
            return $response;
        }

        return $this->destroyRecord($registroAsistencia);
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
}
