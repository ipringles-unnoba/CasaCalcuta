<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Permiso;
use App\Models\Rol;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;

class RolController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return Rol::class;
    }

    protected function relations(): array
    {
        return ['permisos'];
    }

    protected function storeRules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255', 'unique:roles,nombre'],
            'descripcion' => ['required', 'string', 'max:255'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'nombre' => ['sometimes', 'required', 'string', 'max:255', Rule::unique('roles', 'nombre')->ignore($record->getKey(), $record->getKeyName())],
            'descripcion' => ['sometimes', 'required', 'string', 'max:255'],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        return $this->storeRecord($request);
    }

    public function show(Rol $rol): JsonResponse
    {
        return $this->showRecord($rol);
    }

    public function update(Request $request, Rol $rol): JsonResponse
    {
        return $this->updateRecord($request, $rol);
    }

    public function destroy(Rol $rol): Response
    {
        return $this->destroyRecord($rol);
    }

    public function permisos(Rol $rol): JsonResponse
    {
        return response()->json($rol->permisos()->latest('id_permiso')->get());
    }

    public function syncPermisos(Request $request, Rol $rol): JsonResponse
    {
        $data = $request->validate([
            'permisos' => ['required', 'array'],
            'permisos.*' => ['integer', Rule::exists('permisos', 'id_permiso')],
        ]);

        $rol->permisos()->sync($data['permisos']);

        return response()->json($rol->load('permisos'));
    }
}
