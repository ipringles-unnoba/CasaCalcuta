<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\VisitaDomiciliaria;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;

class VisitaDomiciliariaController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return VisitaDomiciliaria::class;
    }

    protected function relations(): array
    {
        return ['familia', 'usuarios'];
    }

    protected function storeRules(): array
    {
        return [
            'fecha' => ['required', 'date'],
            'observaciones' => ['nullable', 'string'],
            'familia_id' => ['required', 'integer', 'exists:familias,id_familia'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'fecha' => ['sometimes', 'required', 'date'],
            'observaciones' => ['nullable', 'string'],
            'familia_id' => ['sometimes', 'required', 'integer', 'exists:familias,id_familia'],
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

    public function show(VisitaDomiciliaria $visitaDomiciliaria): JsonResponse
    {
        return $this->showRecord($visitaDomiciliaria);
    }

    public function update(Request $request, VisitaDomiciliaria $visitaDomiciliaria): JsonResponse
    {
        return $this->updateRecord($request, $visitaDomiciliaria);
    }

    public function destroy(VisitaDomiciliaria $visitaDomiciliaria): Response
    {
        return $this->destroyRecord($visitaDomiciliaria);
    }

    public function usuarios(VisitaDomiciliaria $visitaDomiciliaria): JsonResponse
    {
        return response()->json($visitaDomiciliaria->usuarios()->latest('id_usuario')->get());
    }

    public function syncUsuarios(Request $request, VisitaDomiciliaria $visitaDomiciliaria): JsonResponse
    {
        $data = $request->validate([
            'usuarios' => ['required', 'array'],
            'usuarios.*' => ['integer', Rule::exists('usuarios', 'id_usuario')],
        ]);

        $visitaDomiciliaria->usuarios()->sync($data['usuarios']);

        return response()->json($visitaDomiciliaria->load('usuarios'));
    }
}
