<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\PedidoEspecial;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class PedidoEspecialController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return PedidoEspecial::class;
    }

    protected function relations(): array
    {
        return ['registradoPor', 'familia'];
    }

    protected function storeRules(): array
    {
        return [
            'descripcion' => ['required', 'string', 'max:255'],
            'estado' => ['required', 'string', 'max:255'],
            'fecha_carga' => ['required', 'date'],
            'registrado_por' => ['required', 'integer', 'exists:usuarios,id_usuario'],
            'familia_id' => ['nullable', 'integer', 'exists:familias,id_familia'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'descripcion' => ['sometimes', 'required', 'string', 'max:255'],
            'estado' => ['sometimes', 'required', 'string', 'max:255'],
            'fecha_carga' => ['sometimes', 'required', 'date'],
            'registrado_por' => ['sometimes', 'required', 'integer', 'exists:usuarios,id_usuario'],
            'familia_id' => ['nullable', 'integer', 'exists:familias,id_familia'],
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

    public function show(PedidoEspecial $pedidoEspecial): JsonResponse
    {
        return $this->showRecord($pedidoEspecial);
    }

    public function update(Request $request, PedidoEspecial $pedidoEspecial): JsonResponse
    {
        return $this->updateRecord($request, $pedidoEspecial);
    }

    public function destroy(PedidoEspecial $pedidoEspecial): Response
    {
        return $this->destroyRecord($pedidoEspecial);
    }
}
