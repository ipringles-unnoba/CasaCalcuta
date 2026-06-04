<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Documento;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;

class DocumentoController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return Documento::class;
    }

    protected function relations(): array
    {
        return ['integrantes'];
    }

    protected function storeRules(): array
    {
        return [
            'tipo' => ['required', 'string', 'max:255'],
            'vigente' => ['required', 'boolean'],
            'vencimiento' => ['required', 'date'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'tipo' => ['sometimes', 'required', 'string', 'max:255'],
            'vigente' => ['sometimes', 'required', 'boolean'],
            'vencimiento' => ['sometimes', 'required', 'date'],
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

    public function show(Documento $documento): JsonResponse
    {
        return $this->showRecord($documento);
    }

    public function update(Request $request, Documento $documento): JsonResponse
    {
        return $this->updateRecord($request, $documento);
    }

    public function destroy(Documento $documento): Response
    {
        return $this->destroyRecord($documento);
    }

    public function integrantes(Documento $documento): JsonResponse
    {
        return response()->json($documento->integrantes()->latest('id_integrante')->get());
    }

    public function syncIntegrantes(Request $request, Documento $documento): JsonResponse
    {
        $data = $request->validate([
            'integrantes' => ['required', 'array'],
            'integrantes.*' => ['integer', Rule::exists('integrantes', 'id_integrante')],
        ]);

        $documento->integrantes()->sync($data['integrantes']);

        return response()->json($documento->load('integrantes'));
    }
}
