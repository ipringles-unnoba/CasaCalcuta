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
        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        return $this->storeRecord($request);
    }

    public function show(Comision $comision): JsonResponse
    {
        return $this->showRecord($comision);
    }

    public function update(Request $request, Comision $comision): JsonResponse
    {
        return $this->updateRecord($request, $comision);
    }

    public function destroy(Comision $comision): Response
    {
        return $this->destroyRecord($comision);
    }

    public function participaciones(Comision $comision): JsonResponse
    {
        return response()->json($comision->participaciones()->latest('id_participacion_comision')->get());
    }
}
