<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\AutorizacionController;
use App\Http\Controllers\Api\AuditoriaController;
use App\Http\Controllers\Api\ComisionController;
use App\Http\Controllers\Api\CumpleanoController;
use App\Http\Controllers\Api\DonacionController;
use App\Http\Controllers\Api\DocumentoController;
use App\Http\Controllers\Api\FamiliaController;
use App\Http\Controllers\Api\IntegranteController;
use App\Http\Controllers\Api\NotificacionController;
use App\Http\Controllers\Api\PedidoEspecialController;
use App\Http\Controllers\Api\PermisoController;
use App\Http\Controllers\Api\ParticipacionComisionController;
use App\Http\Controllers\Api\RegistroAsistenciaController;
use App\Http\Controllers\Api\RolController;
use App\Http\Controllers\Api\UsuarioNotificationController;
use App\Http\Controllers\Api\UsuarioController;
use App\Http\Controllers\Api\VisitaDomiciliariaController;
use Illuminate\Support\Facades\Route;

Route::prefix('auth')->group(function () {
    Route::post('login', [AuthController::class, 'login']);
    Route::get('me', [AuthController::class, 'me'])->middleware('auth:api');
    Route::post('refresh', [AuthController::class, 'refresh'])->middleware('auth:api');
    Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:api');
});

Route::middleware('auth:api')->group(function () {
    Route::apiResource('usuarios', UsuarioController::class);
    Route::get('usuarios/{usuario}/notificaciones', [UsuarioNotificationController::class, 'index']);
    Route::post('usuarios/{usuario}/notificaciones/sync', [UsuarioNotificationController::class, 'sync']);

    Route::apiResource('roles', RolController::class)->parameters(['roles' => 'rol']);
    Route::get('roles/{rol}/permisos', [RolController::class, 'permisos']);
    Route::post('roles/{rol}/permisos/sync', [RolController::class, 'syncPermisos']);

    Route::apiResource('permisos', PermisoController::class)->parameters(['permisos' => 'permiso']);
    Route::apiResource('notificaciones', NotificacionController::class)->parameters(['notificaciones' => 'notificacion']);
    Route::apiResource('familias', FamiliaController::class);
    Route::get('familias/{familia}/referente', [FamiliaController::class, 'referente']);
    Route::put('familias/{familia}/referente', [FamiliaController::class, 'syncReferente']);
    Route::delete('familias/{familia}/referente', [FamiliaController::class, 'clearReferente']);
    Route::get('familias/{familia}/integrantes', [FamiliaController::class, 'integrantes']);
    Route::get('familias/{familia}/donaciones', [FamiliaController::class, 'donaciones']);
    Route::get('familias/{familia}/pedidos-especiales', [FamiliaController::class, 'pedidosEspeciales']);
    Route::get('familias/{familia}/visitas-domiciliarias', [FamiliaController::class, 'visitasDomiciliarias']);
    Route::get('familias/{familia}/registros-asistencia', [FamiliaController::class, 'registrosAsistencia']);
    Route::get('familias/{familia}/comisiones', [FamiliaController::class, 'comisiones']);
    Route::post('familias/{familia}/evaluar-prioridad', [FamiliaController::class, 'evaluarPrioridad'])->middleware('verificar.rol:Administrador,Coordinador');

    Route::apiResource('integrantes', IntegranteController::class);
    Route::get('integrantes/{integrante}/documentos', [IntegranteController::class, 'documentos']);
    Route::get('integrantes/{integrante}/participaciones-comision', [IntegranteController::class, 'participacionesComision']);

    Route::apiResource('donaciones', DonacionController::class)->parameters(['donaciones' => 'donacion']);
    Route::apiResource('pedidos-especiales', PedidoEspecialController::class)->parameters(['pedidos-especiales' => 'pedidoEspecial']);
    Route::apiResource('comisiones', ComisionController::class)->parameters(['comisiones' => 'comision']);
    Route::get('comisiones/{comision}/participaciones', [ComisionController::class, 'participaciones']);

    Route::apiResource('participaciones-comision', ParticipacionComisionController::class)->parameters(['participaciones-comision' => 'participacionComision']);
    Route::apiResource('visitas-domiciliarias', VisitaDomiciliariaController::class)->parameters(['visitas-domiciliarias' => 'visitaDomiciliaria']);
    Route::get('visitas-domiciliarias/{visitaDomiciliaria}/usuarios', [VisitaDomiciliariaController::class, 'usuarios']);
    Route::post('visitas-domiciliarias/{visitaDomiciliaria}/usuarios/sync', [VisitaDomiciliariaController::class, 'syncUsuarios']);

    Route::apiResource('autorizaciones', AutorizacionController::class)->parameters(['autorizaciones' => 'autorizacion']);
    Route::apiResource('auditorias', AuditoriaController::class)->only(['index', 'show']);
    Route::apiResource('registros-asistencia', RegistroAsistenciaController::class)->parameters(['registros-asistencia' => 'registroAsistencia']);

    Route::apiResource('documentos', DocumentoController::class);
    Route::get('documentos/{documento}/integrantes', [DocumentoController::class, 'integrantes']);
    Route::post('documentos/{documento}/integrantes/sync', [DocumentoController::class, 'syncIntegrantes']);

    Route::prefix('cumpleanos')->group(function () {
        Route::get('proximos', [CumpleanoController::class, 'proximos']);
        Route::get('mes', [CumpleanoController::class, 'mes']);
    });
});
