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
        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        return $this->storeRecord($request);
    }

    public function show(Permiso $permiso): JsonResponse
    {
        return $this->showRecord($permiso);
    }

    public function update(Request $request, Permiso $permiso): JsonResponse
    {
        return $this->updateRecord($request, $permiso);
    }

    public function destroy(Permiso $permiso): Response
    {
        return $this->destroyRecord($permiso);
    }
}
