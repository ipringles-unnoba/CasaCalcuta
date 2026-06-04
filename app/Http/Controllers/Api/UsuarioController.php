<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreUsuarioRequest;
use App\Http\Requests\UpdateUsuarioRequest;
use App\Http\Resources\UsuarioResource;
use App\Models\Usuario;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class UsuarioController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $usuarios = Usuario::query()
            ->with('rol')
            ->latest('id_usuario')
            ->paginate((int) $request->integer('per_page', 15));

        return UsuarioResource::collection($usuarios)->response();
    }

    public function store(StoreUsuarioRequest $request): JsonResponse
    {
        $usuario = Usuario::query()->create($request->validated());

        return (new UsuarioResource($usuario->load('rol')))
            ->response()
            ->setStatusCode(201);
    }

    public function show(Usuario $usuario): JsonResponse
    {
        return (new UsuarioResource($usuario->load('rol')))->response();
    }

    public function update(UpdateUsuarioRequest $request, Usuario $usuario): JsonResponse
    {
        $usuario->fill($request->validated());
        $usuario->save();

        return (new UsuarioResource($usuario->load('rol')))->response();
    }

    public function destroy(Usuario $usuario): JsonResponse
    {
        $usuario->delete();

        return response()->noContent();
    }
}
