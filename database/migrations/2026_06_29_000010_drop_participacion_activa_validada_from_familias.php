<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('familias', function (Blueprint $table): void {
            $table->dropColumn('participacion_activa_validada');
        });
    }

    public function down(): void
    {
        Schema::table('familias', function (Blueprint $table): void {
            $table->boolean('participacion_activa_validada')->nullable()->after('participacion_merendero');
        });
    }
};
