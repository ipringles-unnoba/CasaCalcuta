<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('familias', function (Blueprint $table) {
            $table->unsignedTinyInteger('puntaje_menores')->nullable()->after('puntaje_prioridad');
            $table->unsignedTinyInteger('puntaje_alimentacion')->nullable()->after('puntaje_menores');
            $table->unsignedTinyInteger('puntaje_asistencia')->nullable()->after('puntaje_alimentacion');
            $table->unsignedTinyInteger('puntaje_participacion')->nullable()->after('puntaje_asistencia');
            $table->foreignId('evaluado_por')->nullable()->after('puntaje_participacion')->constrained('usuarios', 'id_usuario');
            $table->date('fecha_ultima_evaluacion')->nullable()->after('evaluado_por');

            $table->unsignedInteger('puntaje_prioridad')->nullable()->change();
            $table->string('prioridad_social')->nullable()->change();
        });
    }

    public function down(): void
    {
        Schema::table('familias', function (Blueprint $table) {
            $table->dropColumn([
                'puntaje_menores',
                'puntaje_alimentacion',
                'puntaje_asistencia',
                'puntaje_participacion',
                'evaluado_por',
                'fecha_ultima_evaluacion',
            ]);

            $table->unsignedInteger('puntaje_prioridad')->nullable(false)->change();
            $table->string('prioridad_social')->nullable(false)->change();
        });
    }
};
