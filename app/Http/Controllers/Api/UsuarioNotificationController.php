<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Usuario;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class UsuarioNotificationController extends Controller
{
    public function index(Usuario $usuario): JsonResponse
    {
        return response()->json($usuario->notificaciones()->latest('id_notificacion')->get());
    }

    public function sync(Request $request, Usuario $usuario): JsonResponse
    {
        $data = $request->validate([
            'notificaciones' => ['required', 'array'],
            'notificaciones.*' => ['integer', Rule::exists('notificaciones', 'id_notificacion')],
        ]);

        $usuario->notificaciones()->sync($data['notificaciones']);

        return response()->json($usuario->load('notificaciones'));
    }
}
