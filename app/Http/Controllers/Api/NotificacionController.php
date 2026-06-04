<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Notificacion;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class NotificacionController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return Notificacion::class;
    }

    protected function relations(): array
    {
        return ['usuarios'];
    }

    protected function storeRules(): array
    {
        return [
            'fecha' => ['required', 'date'],
            'motivo' => ['required', 'string', 'max:255'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'fecha' => ['sometimes', 'required', 'date'],
            'motivo' => ['sometimes', 'required', 'string', 'max:255'],
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

    public function show(Notificacion $notificacion): JsonResponse
    {
        return $this->showRecord($notificacion);
    }

    public function update(Request $request, Notificacion $notificacion): JsonResponse
    {
        return $this->updateRecord($request, $notificacion);
    }

    public function destroy(Notificacion $notificacion): Response
    {
        return $this->destroyRecord($notificacion);
    }
}
