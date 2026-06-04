<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('familias', function (Blueprint $table) {
            $table->id('id_familia');
            $table->string('direccion');
            $table->string('telefono');
            $table->unsignedInteger('puntaje_prioridad');
            $table->string('prioridad_social');
            $table->string('estado_lista');
            $table->date('fecha_ingreso');
            $table->boolean('activa');
            $table->foreignId('registrado_por')->constrained('usuarios', 'id_usuario');
            $table->timestamps();
        });

        Schema::create('integrantes', function (Blueprint $table) {
            $table->id('id_integrante');
            $table->string('nombre');
            $table->string('apellido');
            $table->date('fecha_nacimiento');
            $table->string('tipo_documento');
            $table->string('numero_documento');
            $table->string('categoria_etaria');
            $table->boolean('referente');
            $table->foreignId('familia_id')->constrained('familias', 'id_familia')->cascadeOnDelete();
            $table->timestamps();
        });

        Schema::create('donaciones', function (Blueprint $table) {
            $table->id('id_donacion');
            $table->string('origen');
            $table->string('descripcion');
            $table->unsignedInteger('cantidad');
            $table->string('unidad_medida');
            $table->date('fecha_recepcion');
            $table->foreignId('registrado_por')->constrained('usuarios', 'id_usuario');
            $table->foreignId('familia_id')->nullable()->constrained('familias', 'id_familia')->nullOnDelete();
            $table->timestamps();
        });

        Schema::create('pedidos_especiales', function (Blueprint $table) {
            $table->id('id_pedido_especial');
            $table->string('descripcion');
            $table->string('estado');
            $table->date('fecha_carga');
            $table->foreignId('registrado_por')->constrained('usuarios', 'id_usuario');
            $table->foreignId('familia_id')->nullable()->constrained('familias', 'id_familia')->nullOnDelete();
            $table->timestamps();
        });

        Schema::create('comisiones', function (Blueprint $table) {
            $table->id('id_comision');
            $table->string('nombre');
            $table->boolean('activa');
            $table->string('descripcion');
            $table->foreignId('encargado')->constrained('usuarios', 'id_usuario');
            $table->timestamps();
        });

        Schema::create('participacion_comision', function (Blueprint $table) {
            $table->id('id_participacion_comision');
            $table->date('fecha_inicio');
            $table->boolean('estado');
            $table->string('observaciones')->nullable();
            $table->foreignId('integrante_id')->constrained('integrantes', 'id_integrante')->cascadeOnDelete();
            $table->foreignId('comision_id')->constrained('comisiones', 'id_comision')->cascadeOnDelete();
            $table->timestamps();
            $table->unique(['integrante_id', 'comision_id']);
        });

        Schema::create('visitas_domiciliarias', function (Blueprint $table) {
            $table->id('id_visita_domiciliaria');
            $table->date('fecha');
            $table->text('observaciones')->nullable();
            $table->foreignId('familia_id')->constrained('familias', 'id_familia')->cascadeOnDelete();
            $table->timestamps();
        });

        Schema::create('autorizaciones', function (Blueprint $table) {
            $table->id('id_autorizacion');
            $table->string('tipo');
            $table->boolean('vigente');
            $table->date('vencimiento');
            $table->timestamps();
        });

        Schema::create('auditorias', function (Blueprint $table) {
            $table->id('id_auditoria');
            $table->foreignId('usuario_id')->constrained('usuarios', 'id_usuario');
            $table->string('accion');
            $table->string('entidad');
            $table->unsignedBigInteger('entidad_id');
            $table->date('fecha');
            $table->text('cambios')->nullable();
            $table->timestamps();
            $table->index(['entidad', 'entidad_id']);
        });

        Schema::create('registros_asistencia', function (Blueprint $table) {
            $table->id('id_registro_asistencia');
            $table->foreignId('familia_id')->constrained('familias', 'id_familia')->cascadeOnDelete();
            $table->date('fecha');
            $table->string('estado');
            $table->foreignId('registrado_por')->constrained('usuarios', 'id_usuario');
            $table->timestamps();
        });

        Schema::create('documentos', function (Blueprint $table) {
            $table->id('id_documento');
            $table->string('tipo');
            $table->boolean('vigente');
            $table->date('vencimiento');
            $table->timestamps();
        });

        Schema::create('documentacion_integrante', function (Blueprint $table) {
            $table->foreignId('documento_id')->constrained('documentos', 'id_documento')->cascadeOnDelete();
            $table->foreignId('integrante_id')->constrained('integrantes', 'id_integrante')->cascadeOnDelete();
            $table->primary(['documento_id', 'integrante_id']);
        });

        Schema::create('visita_domiciliaria_usuario', function (Blueprint $table) {
            $table->foreignId('visita_domiciliaria_id')->constrained('visitas_domiciliarias', 'id_visita_domiciliaria')->cascadeOnDelete();
            $table->foreignId('usuario_visitador')->constrained('usuarios', 'id_usuario')->cascadeOnDelete();
            $table->primary(['visita_domiciliaria_id', 'usuario_visitador']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('visita_domiciliaria_usuario');
        Schema::dropIfExists('documentacion_integrante');
        Schema::dropIfExists('documentos');
        Schema::dropIfExists('registros_asistencia');
        Schema::dropIfExists('auditorias');
        Schema::dropIfExists('autorizaciones');
        Schema::dropIfExists('visitas_domiciliarias');
        Schema::dropIfExists('participacion_comision');
        Schema::dropIfExists('comisiones');
        Schema::dropIfExists('pedidos_especiales');
        Schema::dropIfExists('donaciones');
        Schema::dropIfExists('integrantes');
        Schema::dropIfExists('familias');
    }
};
