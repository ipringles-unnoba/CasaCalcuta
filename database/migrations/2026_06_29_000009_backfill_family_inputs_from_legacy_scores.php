<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasTable('familias')) {
            return;
        }

        if (! Schema::hasColumn('familias', 'situacion_alimentaria')) {
            return;
        }

        if (
            ! Schema::hasColumn('familias', 'puntaje_alimentacion')
            || ! Schema::hasColumn('familias', 'puntaje_asistencia')
            || ! Schema::hasColumn('familias', 'puntaje_participacion')
        ) {
            return;
        }

        $familiasConParticipacionActiva = DB::table('integrantes')
            ->join('participacion_comision', 'participacion_comision.integrante_id', '=', 'integrantes.id_integrante')
            ->whereRaw('LOWER(participacion_comision.estado) = ?', ['activo'])
            ->distinct()
            ->pluck('integrantes.familia_id')
            ->map(fn ($familiaId): int => (int) $familiaId)
            ->all();

        $familiasActivas = array_fill_keys($familiasConParticipacionActiva, true);

        DB::transaction(function () use ($familiasActivas): void {
            DB::table('familias')
                ->orderBy('id_familia')
                ->get([
                    'id_familia',
                    'puntaje_alimentacion',
                    'puntaje_asistencia',
                    'puntaje_participacion',
                    'estado_lista',
                ])
                ->each(function ($familia) use ($familiasActivas): void {
                    $updates = [];

                    if ($familia->puntaje_alimentacion !== null) {
                        $updates['situacion_alimentaria'] = $this->mapSituacionAlimentaria((int) $familia->puntaje_alimentacion);
                    }

                    if ($familia->puntaje_asistencia !== null) {
                        $updates['frecuencia_asistencia'] = $this->mapFrecuenciaAsistencia((int) $familia->puntaje_asistencia);
                    }

                    if ($familia->puntaje_participacion !== null) {
                        $updates['participacion_merendero'] = $this->mapParticipacionMerendero((int) $familia->puntaje_participacion);
                    }

                    if (isset($familiasActivas[(int) $familia->id_familia])) {
                        $updates['participacion_merendero'] = 'activa';
                        $updates['estado_lista'] = 'PRINCIPAL';
                    }

                    if ($updates !== []) {
                        DB::table('familias')
                            ->where('id_familia', $familia->id_familia)
                            ->update($updates);
                    }
                });
        });
    }

    private function mapSituacionAlimentaria(int $puntaje): ?string
    {
        return match ($puntaje) {
            0 => 'sin_urgencia',
            2 => 'moderada',
            3 => 'urgente',
            default => null,
        };
    }

    private function mapFrecuenciaAsistencia(int $puntaje): ?string
    {
        return match ($puntaje) {
            0 => 'ocasional',
            1 => 'semanal',
            2 => 'mas_de_una_vez',
            default => null,
        };
    }

    private function mapParticipacionMerendero(int $puntaje): ?string
    {
        return match ($puntaje) {
            0 => 'no_participa',
            1 => 'ocasional',
            2 => 'activa',
            default => null,
        };
    }
};
