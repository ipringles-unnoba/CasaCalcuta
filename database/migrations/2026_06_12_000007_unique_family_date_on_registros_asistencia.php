<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('registros_asistencia', function (Blueprint $table): void {
            $table->unique(['familia_id', 'fecha'], 'registros_asistencia_familia_id_fecha_unique');
        });
    }

    public function down(): void
    {
        Schema::table('registros_asistencia', function (Blueprint $table): void {
            $table->dropUnique('registros_asistencia_familia_id_fecha_unique');
        });
    }
};
