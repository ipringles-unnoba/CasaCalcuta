<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasTable('familias') || ! Schema::hasTable('participacion_comision') || ! Schema::hasTable('comisiones')) {
            return;
        }

        $familiaIds = DB::table('familias as f')
            ->join('integrantes as i', 'i.familia_id', '=', 'f.id_familia')
            ->join('participacion_comision as pc', 'pc.integrante_id', '=', 'i.id_integrante')
            ->join('comisiones as c', 'c.id_comision', '=', 'pc.comision_id')
            ->where('f.activa', 1)
            ->whereRaw('LOWER(pc.estado) = ?', ['activo'])
            ->where('c.activa', 1)
            ->distinct()
            ->pluck('f.id_familia');

        if ($familiaIds->isEmpty()) {
            return;
        }

        DB::table('familias')
            ->whereIn('id_familia', $familiaIds)
            ->update([
                'participacion_merendero' => 'activa',
                'prioridad_social' => 'muy_alta',
                'estado_lista' => 'PRINCIPAL',
            ]);
    }

    public function down(): void
    {
        // Deshacer este backfill de datos no es determinista.
    }
};
