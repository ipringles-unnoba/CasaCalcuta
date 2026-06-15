<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Integrante;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class CumpleanoController extends Controller
{
    private const VIEW_PERMISSIONS = ['Ver familias', 'Gestionar familias'];

    public function proximos(Request $request): JsonResponse
    {
        if ($response = $this->authorizeViewPermissions($request)) {
            return $response;
        }

        $dias = max(1, $request->integer('dias', 7));

        $integrantes = Integrante::proximosCumpleanos($dias)
            ->with('familia')
            ->orderByRaw("DATE_FORMAT(fecha_nacimiento, '%m-%d')")
            ->get();

        $result = $integrantes->map(function (Integrante $integrante): array {
            $nextBirthday = $integrante->fecha_nacimiento->copy()->setYear(now()->year);
            if ($nextBirthday->isPast()) {
                $nextBirthday->addYear();
            }

            return [
                'id_integrante' => $integrante->id_integrante,
                'nombre' => $integrante->nombre,
                'apellido' => $integrante->apellido,
                'edad_a_cumplir' => $integrante->fecha_nacimiento->age + 1,
                'fecha_cumple' => $nextBirthday->toDateString(),
                'dias_restantes' => (int) now()->startOfDay()->diffInDays($nextBirthday),
                'familia' => $integrante->familia,
            ];
        });

        return response()->json($result);
    }

    public function mes(Request $request): JsonResponse
    {
        if ($response = $this->authorizeViewPermissions($request)) {
            return $response;
        }

        $mes = $request->integer('mes', now()->month);
        $mes = max(1, min(12, $mes));

        $integrantes = Integrante::cumpleanosDelMes($mes)
            ->with('familia')
            ->orderByRaw("DATE_FORMAT(fecha_nacimiento, '%m-%d')")
            ->get();

        $result = $integrantes->map(function (Integrante $integrante): array {
            $nextBirthday = $integrante->fecha_nacimiento->copy()->setYear(now()->year);
            if ($nextBirthday->isPast()) {
                $nextBirthday->addYear();
            }

            return [
                'id_integrante' => $integrante->id_integrante,
                'nombre' => $integrante->nombre,
                'apellido' => $integrante->apellido,
                'edad_a_cumplir' => $integrante->fecha_nacimiento->age + 1,
                'fecha_cumple' => $nextBirthday->toDateString(),
                'familia' => $integrante->familia,
            ];
        });

        return response()->json($result);
    }

    private function authorizeViewPermissions(Request $request): ?JsonResponse
    {
        $usuario = $request->user();

        if ($usuario === null) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }

        $usuario->loadMissing('rol.permisos');
        $permissions = $usuario->rol?->permisos ?? collect();
        $requiredPermissions = array_map('mb_strtolower', self::VIEW_PERMISSIONS);

        foreach ($permissions as $permiso) {
            if (in_array(mb_strtolower($permiso->nombre), $requiredPermissions, true)) {
                return null;
            }
        }

        return response()->json(['message' => 'Acceso no autorizado. Falta el permiso: ' . implode(' o ', self::VIEW_PERMISSIONS) . '.'], 403);
    }
}
