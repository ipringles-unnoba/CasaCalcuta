<?php

namespace App\Services;

use App\Models\Familia;
use App\Models\Usuario;
use Illuminate\Support\Facades\DB;

class PriorizacionSocialService
{
    const PUNTAJE_PARTICIPACION_ACTIVA = 2;

    const PUNTAJE_MENORES_VALORES = [0, 1, 2];
    const PUNTAJE_ALIMENTACION_VALORES = [0, 2, 3];
    const PUNTAJE_ASISTENCIA_VALORES = [0, 1, 2];
    const PUNTAJE_PARTICIPACION_VALORES = [0, 1, 2];

    const NIVELES = [
        'muy_baja' => [0, 1],
        'baja' => [2, 3],
        'media' => [4, 5],
        'alta' => [6, 7],
        'muy_alta' => [8, PHP_INT_MAX],
    ];

    public function calcularPuntaje(array $criterios): array
    {
        $puntajeMenores = $criterios['puntaje_menores'] ?? 0;
        $puntajeAlimentacion = $criterios['puntaje_alimentacion'] ?? 0;
        $puntajeAsistencia = $criterios['puntaje_asistencia'] ?? 0;
        $puntajeParticipacion = $criterios['puntaje_participacion'] ?? 0;

        $participacionActiva = $puntajeParticipacion === self::PUNTAJE_PARTICIPACION_ACTIVA;

        $puntajeTotal = $puntajeMenores + $puntajeAlimentacion + $puntajeAsistencia + $puntajeParticipacion;

        $nivel = $this->obtenerNivel($puntajeTotal, $participacionActiva);

        return [
            'puntaje_menores' => $puntajeMenores,
            'puntaje_alimentacion' => $puntajeAlimentacion,
            'puntaje_asistencia' => $puntajeAsistencia,
            'puntaje_participacion' => $puntajeParticipacion,
            'puntaje_total' => $puntajeTotal,
            'nivel' => $nivel,
        ];
    }

    public function obtenerNivel(int $puntajeTotal, bool $participacionActiva = false): string
    {
        if ($participacionActiva) {
            return 'muy_alta';
        }

        foreach (self::NIVELES as $nivel => [$min, $max]) {
            if ($puntajeTotal >= $min && $puntajeTotal <= $max) {
                return $nivel;
            }
        }

        return 'muy_baja';
    }

    public function evaluar(Familia $familia, array $criterios, Usuario $usuario): Familia
    {
        $resultado = $this->calcularPuntaje($criterios);

        DB::transaction(function () use ($familia, $resultado, $usuario): void {
            $familia->forceFill([
                'puntaje_prioridad' => $resultado['puntaje_total'],
                'prioridad_social' => $resultado['nivel'],
                'puntaje_menores' => $resultado['puntaje_menores'],
                'puntaje_alimentacion' => $resultado['puntaje_alimentacion'],
                'puntaje_asistencia' => $resultado['puntaje_asistencia'],
                'puntaje_participacion' => $resultado['puntaje_participacion'],
                'evaluado_por' => $usuario->id_usuario,
                'fecha_ultima_evaluacion' => now()->toDateString(),
            ])->save();
        });

        return $familia->fresh(['registradoPor', 'referente', 'evaluadoPor']);
    }
}
