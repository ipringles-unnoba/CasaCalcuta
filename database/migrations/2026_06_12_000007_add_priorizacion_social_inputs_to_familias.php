<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('familias', function (Blueprint $table): void {
            if (! Schema::hasColumn('familias', 'situacion_alimentaria')) {
                $column = $table->string('situacion_alimentaria', 50)->nullable();
                if (Schema::hasColumn('familias', 'puntaje_menores')) {
                    $column->after('puntaje_menores');
                }
            }

            if (! Schema::hasColumn('familias', 'frecuencia_asistencia')) {
                $column = $table->string('frecuencia_asistencia', 50)->nullable();
                if (Schema::hasColumn('familias', 'situacion_alimentaria')) {
                    $column->after('situacion_alimentaria');
                }
            }

            if (! Schema::hasColumn('familias', 'participacion_merendero')) {
                $column = $table->string('participacion_merendero', 50)->nullable();
                if (Schema::hasColumn('familias', 'frecuencia_asistencia')) {
                    $column->after('frecuencia_asistencia');
                }
            }

            if (! Schema::hasColumn('familias', 'participacion_activa_validada')) {
                $column = $table->boolean('participacion_activa_validada')->nullable();
                if (Schema::hasColumn('familias', 'participacion_merendero')) {
                    $column->after('participacion_merendero');
                }
            }
        });
    }

    public function down(): void
    {
        Schema::table('familias', function (Blueprint $table): void {
            $table->dropColumn([
                'situacion_alimentaria',
                'frecuencia_asistencia',
                'participacion_merendero',
                'participacion_activa_validada',
            ]);
        });
    }
};
