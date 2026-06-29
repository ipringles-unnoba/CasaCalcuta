<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('familias', function (Blueprint $table): void {
            $table->dropColumn([
                'puntaje_menores',
                'puntaje_alimentacion',
                'puntaje_asistencia',
                'puntaje_participacion',
            ]);
        });
    }

    public function down(): void
    {
        Schema::table('familias', function (Blueprint $table): void {
            $table->unsignedTinyInteger('puntaje_menores')->nullable()->after('puntaje_prioridad');
            $table->unsignedTinyInteger('puntaje_alimentacion')->nullable()->after('puntaje_menores');
            $table->unsignedTinyInteger('puntaje_asistencia')->nullable()->after('puntaje_alimentacion');
            $table->unsignedTinyInteger('puntaje_participacion')->nullable()->after('puntaje_asistencia');
        });
    }
};
