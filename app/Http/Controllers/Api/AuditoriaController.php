<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Auditoria;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class AuditoriaController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return Auditoria::class;
    }

    protected function relations(): array
    {
        return ['usuario'];
    }

    protected function storeRules(): array
    {
        return [];
    }

    protected function updateRules(\Illuminate\Database\Eloquent\Model $record): array
    {
        return [];
    }

    public function index(Request $request): JsonResponse
    {
        return $this->indexRecords($request);
    }

    public function show(Auditoria $auditoria): JsonResponse
    {
        return $this->showRecord($auditoria);
    }

    public function store(Request $request): JsonResponse
    {
        return response()->json(['message' => 'Operación no permitida.'], 405);
    }

    public function update(Request $request, Auditoria $auditoria): JsonResponse
    {
        return response()->json(['message' => 'Operación no permitida.'], 405);
    }

    public function destroy(Auditoria $auditoria): Response
    {
        return response()->noContent();
    }
}
