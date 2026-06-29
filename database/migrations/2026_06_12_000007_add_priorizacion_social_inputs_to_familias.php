<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('familias', function (Blueprint $table): void {
            $table->string('situacion_alimentaria', 50)->nullable()->after('puntaje_menores');
            $table->string('frecuencia_asistencia', 50)->nullable()->after('situacion_alimentaria');
            $table->string('participacion_merendero', 50)->nullable()->after('frecuencia_asistencia');
            $table->boolean('participacion_activa_validada')->nullable()->after('participacion_merendero');
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
