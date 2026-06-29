<?php

namespace App\Services;

use App\Models\Familia;
use App\Models\Usuario;
use Illuminate\Support\Facades\DB;

class PriorizacionSocialService
{
    private const NIVELES = [
        'muy_baja' => [0, 1],
        'baja' => [2, 3],
        'media' => [4, 5],
        'alta' => [6, 7],
        'muy_alta' => [8, PHP_INT_MAX],
    ];

    public function calcularPuntaje(Familia $familia, array $criterios): array
    {
        $situacionAlimentaria = $criterios['situacion_alimentaria'] ?? 'sin_urgencia';
        $frecuenciaAsistencia = $criterios['frecuencia_asistencia'] ?? 'ocasional';
        $participacionMerendero = $criterios['participacion_merendero'] ?? 'no_participa';
        $participacionComisionActiva = $familia->tieneParticipacionComisionActiva();

        if ($participacionComisionActiva) {
            $participacionMerendero = 'activa';
        }

        $familia->forceFill([
            'situacion_alimentaria' => $situacionAlimentaria,
            'frecuencia_asistencia' => $frecuenciaAsistencia,
            'participacion_merendero' => $participacionMerendero,
        ]);

        $puntajeMenores = $familia->puntaje_menores;
        $puntajeAlimentacion = $familia->puntaje_alimentacion;
        $puntajeAsistencia = $familia->puntaje_asistencia;
        $puntajeParticipacion = $familia->puntaje_participacion;

        $puntajeTotal = $puntajeMenores + $puntajeAlimentacion + $puntajeAsistencia + $puntajeParticipacion;

        $nivel = $participacionComisionActiva ? 'muy_alta' : $this->obtenerNivel($puntajeTotal);

        return [
            'situacion_alimentaria' => $situacionAlimentaria,
            'frecuencia_asistencia' => $frecuenciaAsistencia,
            'participacion_merendero' => $participacionMerendero,
            'puntaje_menores' => $puntajeMenores,
            'puntaje_alimentacion' => $puntajeAlimentacion,
            'puntaje_asistencia' => $puntajeAsistencia,
            'puntaje_participacion' => $puntajeParticipacion,
            'puntaje_total' => $puntajeTotal,
            'nivel' => $nivel,
            'estado_lista_forzado' => $participacionComisionActiva,
        ];
    }

    public function obtenerNivel(int $puntajeTotal): string
    {
        foreach (self::NIVELES as $nivel => [$min, $max]) {
            if ($puntajeTotal >= $min && $puntajeTotal <= $max) {
                return $nivel;
            }
        }

        return 'muy_baja';
    }

    public function evaluar(Familia $familia, array $criterios, Usuario $usuario): Familia
    {
        $resultado = $this->calcularPuntaje($familia, $criterios);

        DB::transaction(function () use ($familia, $resultado, $usuario): void {
            $familia->forceFill([
                'puntaje_prioridad' => $resultado['puntaje_total'],
                'prioridad_social' => $resultado['nivel'],
                'estado_lista' => $resultado['estado_lista_forzado'] ? 'PRINCIPAL' : $familia->estado_lista,
                'evaluado_por' => $usuario->id_usuario,
                'fecha_ultima_evaluacion' => now()->toDateString(),
            ])->save();
        });

        return $familia->fresh(['registradoPor', 'referente', 'evaluadoPor']);
    }
}
