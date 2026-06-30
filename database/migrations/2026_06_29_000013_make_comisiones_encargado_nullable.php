<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasColumn('comisiones', 'encargado')) {
            return;
        }

        DB::statement('ALTER TABLE `comisiones` MODIFY `encargado` BIGINT UNSIGNED NULL');
    }

    public function down(): void
    {
        if (! Schema::hasColumn('comisiones', 'encargado')) {
            return;
        }

        if (DB::table('comisiones')->whereNull('encargado')->exists()) {
            return;
        }

        DB::statement('ALTER TABLE `comisiones` MODIFY `encargado` BIGINT UNSIGNED NOT NULL');
    }
};
