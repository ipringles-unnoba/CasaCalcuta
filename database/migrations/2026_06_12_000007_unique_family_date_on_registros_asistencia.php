<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if ($this->indexExists('registros_asistencia', 'registros_asistencia_familia_id_fecha_unique')) {
            return;
        }

        Schema::table('registros_asistencia', function (Blueprint $table): void {
            $table->unique(['familia_id', 'fecha'], 'registros_asistencia_familia_id_fecha_unique');
        });
    }

    public function down(): void
    {
        if (! $this->indexExists('registros_asistencia', 'registros_asistencia_familia_id_fecha_unique')) {
            return;
        }

        Schema::table('registros_asistencia', function (Blueprint $table): void {
            $table->dropUnique('registros_asistencia_familia_id_fecha_unique');
        });
    }

    private function indexExists(string $table, string $index): bool
    {
        $row = DB::selectOne(
            'SELECT COUNT(*) AS aggregate FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = ? AND index_name = ?',
            [$table, $index]
        );

        return ((int) ($row->aggregate ?? 0)) > 0;
    }
};
