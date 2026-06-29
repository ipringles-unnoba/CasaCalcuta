<?php

namespace App\Services;

use App\Models\Familia;
use App\Models\Usuario;
use Illuminate\Support\Facades\DB;

class PriorizacionSocialService
{
    private const SITUACION_ALIMENTARIA_PUNTAJES = [
        'sin_urgencia' => 0,
        'moderada' => 2,
        'urgente' => 3,
    ];

    private const FRECUENCIA_ASISTENCIA_PUNTAJES = [
        'ocasional' => 0,
        'semanal' => 1,
        'mas_de_una_vez' => 2,
    ];

    private const PARTICIPACION_MERENDERO_PUNTAJES = [
        'no_participa' => 0,
        'ocasional' => 1,
        'activa' => 2,
    ];

    const NIVELES = [
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

        $puntajeMenores = $this->calcularPuntajeMenores($familia);
        $puntajeAlimentacion = self::SITUACION_ALIMENTARIA_PUNTAJES[$situacionAlimentaria] ?? 0;
        $puntajeAsistencia = self::FRECUENCIA_ASISTENCIA_PUNTAJES[$frecuenciaAsistencia] ?? 0;
        $puntajeParticipacion = self::PARTICIPACION_MERENDERO_PUNTAJES[$participacionMerendero] ?? 0;

        $puntajeTotal = $puntajeMenores + $puntajeAlimentacion + $puntajeAsistencia + $puntajeParticipacion;

        $nivel = $this->obtenerNivel($puntajeTotal);

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

    private function calcularPuntajeMenores(Familia $familia): int
    {
        $cantidadMenores = $familia->integrantes()
            ->get()
            ->filter(fn ($integrante): bool => $integrante->categoria_etaria === 'MENOR')
            ->count();

        return match (true) {
            $cantidadMenores === 0 => 0,
            $cantidadMenores <= 2 => 1,
            default => 2,
        };
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
                'situacion_alimentaria' => $resultado['situacion_alimentaria'],
                'frecuencia_asistencia' => $resultado['frecuencia_asistencia'],
                'participacion_merendero' => $resultado['participacion_merendero'],
                'puntaje_prioridad' => $resultado['puntaje_total'],
                'prioridad_social' => $resultado['nivel'],
                'puntaje_menores' => $resultado['puntaje_menores'],
                'puntaje_alimentacion' => $resultado['puntaje_alimentacion'],
                'puntaje_asistencia' => $resultado['puntaje_asistencia'],
                'puntaje_participacion' => $resultado['puntaje_participacion'],
                'estado_lista' => $resultado['estado_lista_forzado'] ? 'PRINCIPAL' : $familia->estado_lista,
                'evaluado_por' => $usuario->id_usuario,
                'fecha_ultima_evaluacion' => now()->toDateString(),
            ])->save();
        });

        return $familia->fresh(['registradoPor', 'referente', 'evaluadoPor']);
    }
}
