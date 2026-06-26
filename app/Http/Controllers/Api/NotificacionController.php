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
        $usuario = $request->user();

        if ($usuario === null) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        return response()->json(
            $usuario->notificaciones()
                ->where('visto', false)
                ->with('usuarios')
                ->latest('id_notificacion')
                ->paginate((int) $request->integer('per_page', 15))
        );
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

    public function visto(Request $request, Notificacion $notificacion): JsonResponse
    {
        $usuario = $request->user();

        if ($usuario === null) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        if (! $usuario->notificaciones()->whereKey($notificacion->getKey())->exists()) {
            return response()->json(['message' => 'Notificación no encontrada.'], 404);
        }

        $notificacion->forceFill(['visto' => true])->save();

        return response()->json($notificacion->load('usuarios'));
    }

    public function destroy(Notificacion $notificacion): Response
    {
        return $this->destroyRecord($notificacion);
    }
}
