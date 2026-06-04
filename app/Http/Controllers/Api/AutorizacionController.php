<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Autorizacion;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class AutorizacionController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return Autorizacion::class;
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

    public function show(Autorizacion $autorizacion): JsonResponse
    {
        return $this->showRecord($autorizacion);
    }

    public function update(Request $request, Autorizacion $autorizacion): JsonResponse
    {
        return $this->updateRecord($request, $autorizacion);
    }

    public function destroy(Autorizacion $autorizacion): Response
    {
        return $this->destroyRecord($autorizacion);
    }
}
