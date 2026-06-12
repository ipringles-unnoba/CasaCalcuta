<?php

namespace App\Http\Controllers\Api\Concerns;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

trait AuthenticatedRegistrar
{
    private function applyAuthenticatedRegistrar(Request $request, array $data, string $field = 'registrado_por'): array|JsonResponse
    {
        if (array_key_exists($field, $data) && $data[$field] !== null && $data[$field] !== '') {
            return $data;
        }

        $usuario = $request->user();

        if ($usuario === null) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        $data[$field] = $usuario->getKey();

        return $data;
    }
}
