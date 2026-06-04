<?php

namespace App\Http\Controllers\Api\Concerns;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

trait CrudController
{
    abstract protected function modelClass(): string;

    abstract protected function storeRules(): array;

    abstract protected function updateRules(Model $record): array;

    protected function relations(): array
    {
        return [];
    }

    protected function orderBy(): string
    {
        $class = $this->modelClass();

        return (new $class())->getKeyName();
    }

    protected function indexRecords(Request $request): JsonResponse
    {
        $query = ($this->modelClass())::query()->with($this->relations())->latest($this->orderBy());

        return response()->json($query->paginate((int) $request->integer('per_page', 15)));
    }

    protected function storeRecord(Request $request): JsonResponse
    {
        $record = ($this->modelClass())::query()->create($request->validate($this->storeRules()));

        return response()->json($record->load($this->relations()), 201);
    }

    protected function showRecord(Model $record): JsonResponse
    {
        return response()->json($record->load($this->relations()));
    }

    protected function updateRecord(Request $request, Model $record): JsonResponse
    {
        $record->fill($request->validate($this->updateRules($record)));
        $record->save();

        return response()->json($record->load($this->relations()));
    }

    protected function destroyRecord(Model $record): Response
    {
        $record->delete();

        return response()->noContent();
    }
}
