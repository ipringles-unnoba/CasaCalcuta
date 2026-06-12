<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Api\Concerns\AuthenticatedRegistrar;
use App\Http\Controllers\Controller;
use App\Models\PedidoEspecial;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class PedidoEspecialController extends Controller
{
    use AuthenticatedRegistrar, CrudController;

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
            'registrado_por' => ['sometimes', 'integer', 'exists:usuarios,id_usuario'],
            'familia_id' => ['nullable', 'integer', 'exists:familias,id_familia'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'descripcion' => ['sometimes', 'required', 'string', 'max:255'],
            'estado' => ['sometimes', 'required', 'string', 'max:255'],
            'fecha_carga' => ['sometimes', 'required', 'date'],
            'registrado_por' => ['sometimes', 'integer', 'exists:usuarios,id_usuario'],
            'familia_id' => ['nullable', 'integer', 'exists:familias,id_familia'],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        $data = $request->validate($this->storeRules());
        $data = $this->applyAuthenticatedRegistrar($request, $data);

        if ($data instanceof JsonResponse) {
            return $data;
        }

        $record = PedidoEspecial::query()->create($data);

        return response()->json($record->load($this->relations()), 201);
    }

    public function show(PedidoEspecial $pedidoEspecial): JsonResponse
    {
        return $this->showRecord($pedidoEspecial);
    }

    public function update(Request $request, PedidoEspecial $pedidoEspecial): JsonResponse
    {
        $data = $request->validate($this->updateRules($pedidoEspecial));
        $data = $this->applyAuthenticatedRegistrar($request, $data);

        if ($data instanceof JsonResponse) {
            return $data;
        }

        $pedidoEspecial->fill($data);
        $pedidoEspecial->save();

        return response()->json($pedidoEspecial->load($this->relations()));
    }

    public function destroy(PedidoEspecial $pedidoEspecial): Response
    {
        return $this->destroyRecord($pedidoEspecial);
    }
}
