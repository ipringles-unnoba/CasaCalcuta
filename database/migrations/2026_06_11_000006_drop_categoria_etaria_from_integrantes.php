<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('integrantes', function (Blueprint $table) {
            $table->dropColumn('categoria_etaria');
        });
    }

    public function down(): void
    {
        Schema::table('integrantes', function (Blueprint $table) {
            $table->string('categoria_etaria')->after('fecha_nacimiento');
        });
    }
};
