<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreUsuarioRequest;
use App\Http\Requests\UpdateUsuarioRequest;
use App\Http\Resources\UsuarioResource;
use App\Models\Usuario;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class UsuarioController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        if ($response = $this->authorizeUserPermissions($request, ['Ver usuarios', 'Gestionar usuarios'])) {
            return $response;
        }

        $usuarios = Usuario::query()
            ->with('rol')
            ->latest('id_usuario')
            ->paginate((int) $request->integer('per_page', 15));

        return UsuarioResource::collection($usuarios)->response();
    }

    public function store(StoreUsuarioRequest $request): JsonResponse
    {
        if ($response = $this->authorizeUserPermissions($request, ['Gestionar usuarios'])) {
            return $response;
        }

        $usuario = Usuario::query()->create($request->validated());

        return (new UsuarioResource($usuario->load('rol')))
            ->response()
            ->setStatusCode(201);
    }

    public function show(Usuario $usuario): JsonResponse
    {
        if ($response = $this->authorizeUserPermissions(request(), ['Ver usuarios', 'Gestionar usuarios'])) {
            return $response;
        }

        return (new UsuarioResource($usuario->load('rol')))->response();
    }

    public function update(UpdateUsuarioRequest $request, Usuario $usuario): JsonResponse
    {
        if ($response = $this->authorizeUserPermissions($request, ['Gestionar usuarios'])) {
            return $response;
        }

        $usuario->fill($request->validated());
        $usuario->save();

        return (new UsuarioResource($usuario->load('rol')))->response();
    }

    public function destroy(Usuario $usuario): JsonResponse|Response
    {
        if ($response = $this->authorizeUserPermissions(request(), ['Gestionar usuarios'])) {
            return $response;
        }

        $usuario->delete();

        return response()->noContent();
    }

    private function authorizeUserPermissions(Request $request, array $requiredPermissions): ?JsonResponse
    {
        $usuario = $request->user();

        if ($usuario === null) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        $usuario->loadMissing('rol.permisos');

        $permissions = $usuario->rol?->permisos ?? collect();
        $requiredPermissions = array_map('mb_strtolower', $requiredPermissions);

        foreach ($permissions as $permiso) {
            if (in_array(mb_strtolower($permiso->nombre), $requiredPermissions, true)) {
                return null;
            }
        }

        return response()->json(['message' => 'Acceso no autorizado. Falta el permiso: ' . implode(' o ', $requiredPermissions) . '.'], 403);
    }
}
