<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('participacion_comision', function (Blueprint $table) {
            $table->string('estado', 20)->default('activo')->change();
        });
    }

    public function down(): void
    {
        Schema::table('participacion_comision', function (Blueprint $table) {
            $table->boolean('estado')->default(true)->change();
        });
    }
};
