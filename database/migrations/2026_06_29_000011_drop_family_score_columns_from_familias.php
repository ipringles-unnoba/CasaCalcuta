<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        $columns = array_values(array_filter([
            Schema::hasColumn('familias', 'puntaje_menores') ? 'puntaje_menores' : null,
            Schema::hasColumn('familias', 'puntaje_alimentacion') ? 'puntaje_alimentacion' : null,
            Schema::hasColumn('familias', 'puntaje_asistencia') ? 'puntaje_asistencia' : null,
            Schema::hasColumn('familias', 'puntaje_participacion') ? 'puntaje_participacion' : null,
        ]));

        if ($columns === []) {
            return;
        }

        Schema::table('familias', function (Blueprint $table) use ($columns): void {
            $table->dropColumn($columns);
        });
    }

    public function down(): void
    {
        Schema::table('familias', function (Blueprint $table): void {
            if (! Schema::hasColumn('familias', 'puntaje_menores')) {
                $table->unsignedTinyInteger('puntaje_menores')->nullable()->after('puntaje_prioridad');
            }

            if (! Schema::hasColumn('familias', 'puntaje_alimentacion')) {
                $table->unsignedTinyInteger('puntaje_alimentacion')->nullable()->after('puntaje_menores');
            }

            if (! Schema::hasColumn('familias', 'puntaje_asistencia')) {
                $table->unsignedTinyInteger('puntaje_asistencia')->nullable()->after('puntaje_alimentacion');
            }

            if (! Schema::hasColumn('familias', 'puntaje_participacion')) {
                $table->unsignedTinyInteger('puntaje_participacion')->nullable()->after('puntaje_asistencia');
            }
        });
    }
};
