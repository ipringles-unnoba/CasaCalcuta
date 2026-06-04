<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\ParticipacionComision;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class ParticipacionComisionController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return ParticipacionComision::class;
    }

    protected function relations(): array
    {
        return ['integrante', 'comision'];
    }

    protected function storeRules(): array
    {
        return [
            'fecha_inicio' => ['required', 'date'],
            'estado' => ['required', 'boolean'],
            'observaciones' => ['nullable', 'string', 'max:255'],
            'integrante_id' => ['required', 'integer', 'exists:integrantes,id_integrante'],
            'comision_id' => ['required', 'integer', 'exists:comisiones,id_comision'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'fecha_inicio' => ['sometimes', 'required', 'date'],
            'estado' => ['sometimes', 'required', 'boolean'],
            'observaciones' => ['nullable', 'string', 'max:255'],
            'integrante_id' => ['sometimes', 'required', 'integer', 'exists:integrantes,id_integrante'],
            'comision_id' => ['sometimes', 'required', 'integer', 'exists:comisiones,id_comision'],
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

    public function show(ParticipacionComision $participacionComision): JsonResponse
    {
        return $this->showRecord($participacionComision);
    }

    public function update(Request $request, ParticipacionComision $participacionComision): JsonResponse
    {
        return $this->updateRecord($request, $participacionComision);
    }

    public function destroy(ParticipacionComision $participacionComision): Response
    {
        return $this->destroyRecord($participacionComision);
    }
}
