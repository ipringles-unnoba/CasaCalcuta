<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('familias', function (Blueprint $table) {
            $table->foreignId('referente_id')
                ->nullable()
                ->after('activa')
                ->constrained('integrantes', 'id_integrante')
                ->nullOnDelete();

            $table->unique('referente_id');
        });

        Schema::table('integrantes', function (Blueprint $table) {
            $table->unique('numero_documento');
        });
    }

    public function down(): void
    {
        Schema::table('integrantes', function (Blueprint $table) {
            $table->dropUnique('integrantes_numero_documento_unique');
        });

        Schema::table('familias', function (Blueprint $table) {
            $table->dropUnique('familias_referente_id_unique');
            $table->dropConstrainedForeignId('referente_id');
        });
    }
};
