<?php

namespace Tests\Feature\Api;

use App\Models\Familia;
use App\Models\Comision;
use App\Models\Integrante;
use App\Models\ParticipacionComision;
use App\Models\Permiso;
use App\Models\Rol;
use App\Models\Usuario;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class FamiliaPrioridadTest extends TestCase
{
    use RefreshDatabase;

    public function test_store_familia_sets_registrado_por_automatically(): void
    {
        $user = $this->userWithPermissions(['Gestionar familias', 'Gestionar listas']);

        $this->actingAs($user, 'api')
            ->postJson('/api/familias', [
                'direccion' => 'Calle Falsa 123',
                'telefono' => '555-1234',
                'estado_lista' => 'ESPERA',
                'fecha_ingreso' => now()->toDateString(),
                'activa' => true,
            ])
            ->assertCreated()
            ->assertJsonPath('direccion', 'Calle Falsa 123');

        $this->assertDatabaseHas('familias', [
            'direccion' => 'Calle Falsa 123',
            'registrado_por' => $user->id_usuario,
        ]);
    }

    public function test_participacion_activa_comision_forza_estado_principal_y_merendero_activa(): void
    {
        $user = $this->userWithPermissions(['Gestionar familias', 'Gestionar listas']);

        $familia = Familia::query()->create([
            'direccion' => 'Familia Prueba 1',
            'telefono' => '555-0001',
            'estado_lista' => 'ESPERA',
            'fecha_ingreso' => now()->toDateString(),
            'activa' => true,
            'registrado_por' => $user->id_usuario,
        ]);

        Integrante::query()->create([
            'nombre' => 'Menor',
            'apellido' => 'Prueba',
            'fecha_nacimiento' => now()->subYears(10)->toDateString(),
            'tipo_documento' => 'DNI',
            'numero_documento' => 'DOC-001',
            'referente' => false,
            'familia_id' => $familia->id_familia,
        ]);

        Integrante::query()->create([
            'nombre' => 'Adulto',
            'apellido' => 'Prueba',
            'fecha_nacimiento' => now()->subYears(30)->toDateString(),
            'tipo_documento' => 'DNI',
            'numero_documento' => 'DOC-002',
            'referente' => true,
            'familia_id' => $familia->id_familia,
        ]);

        $comision = Comision::query()->create([
            'nombre' => 'Costura de prueba',
            'activa' => true,
            'descripcion' => 'Comision de prueba',
            'encargado' => $user->id_usuario,
        ]);

        $participacion = ParticipacionComision::query()->create([
            'fecha_inicio' => now()->toDateString(),
            'estado' => 'activo',
            'observaciones' => 'Participacion activa de prueba',
            'integrante_id' => $familia->integrantes()->firstOrFail()->id_integrante,
            'comision_id' => $comision->id_comision,
        ]);

        $this->actingAs($user, 'api')
            ->putJson('/api/familias/' . $familia->id_familia, [
                'estado_lista' => 'ESPERA',
            ])
            ->assertOk()
            ->assertJsonPath('estado_lista', 'PRINCIPAL');

        $this->actingAs($user, 'api')
            ->postJson('/api/familias/' . $familia->id_familia . '/evaluar-prioridad', [
                'situacion_alimentaria' => 'moderada',
                'frecuencia_asistencia' => 'semanal',
                'participacion_merendero' => 'activa',
            ])
            ->assertOk()
            ->assertJsonPath('situacion_alimentaria', 'moderada')
            ->assertJsonPath('frecuencia_asistencia', 'semanal')
            ->assertJsonPath('participacion_merendero', 'activa')
            ->assertJsonPath('puntaje_menores', 1)
            ->assertJsonPath('puntaje_alimentacion', 2)
            ->assertJsonPath('puntaje_asistencia', 1)
            ->assertJsonPath('puntaje_participacion', 2)
            ->assertJsonPath('puntaje_prioridad', 6)
            ->assertJsonPath('prioridad_social', 'muy_alta')
            ->assertJsonPath('estado_lista', 'PRINCIPAL')
            ->assertJsonMissingPath('participacion_activa_validada');

        $this->assertDatabaseHas('familias', [
            'id_familia' => $familia->id_familia,
            'situacion_alimentaria' => 'moderada',
            'frecuencia_asistencia' => 'semanal',
            'participacion_merendero' => 'activa',
            'puntaje_prioridad' => 6,
            'prioridad_social' => 'muy_alta',
            'estado_lista' => 'PRINCIPAL',
        ]);

        $participacion->forceFill(['estado' => 'inactivo'])->save();

        $this->actingAs($user, 'api')
            ->putJson('/api/familias/' . $familia->id_familia, [
                'estado_lista' => 'ESPERA',
            ])
            ->assertOk()
            ->assertJsonPath('estado_lista', 'ESPERA');

        $this->actingAs($user, 'api')
            ->postJson('/api/familias/' . $familia->id_familia . '/evaluar-prioridad', [
                'situacion_alimentaria' => 'moderada',
                'frecuencia_asistencia' => 'semanal',
                'participacion_merendero' => 'ocasional',
            ])
            ->assertOk()
            ->assertJsonPath('participacion_merendero', 'ocasional')
            ->assertJsonPath('puntaje_participacion', 1)
            ->assertJsonPath('puntaje_prioridad', 5)
            ->assertJsonPath('prioridad_social', 'media')
            ->assertJsonMissingPath('participacion_activa_validada');
    }

    private function userWithPermissions(array $permissionNames): Usuario
    {
        $rol = Rol::query()->create([
            'nombre' => 'Coordinador',
            'descripcion' => 'Rol de prueba',
        ]);

        foreach ($permissionNames as $permissionName) {
            $permiso = Permiso::query()->create([
                'nombre' => $permissionName,
                'modulo' => 'Familias',
            ]);

            $rol->permisos()->attach($permiso->id_permiso);
        }

        return Usuario::query()->create([
            'nombre' => 'Usuario',
            'apellido' => 'Prueba',
            'email' => strtolower(str_replace(' ', '', implode('', $permissionNames))) . '@example.com',
            'contrasena' => 'password',
            'activo' => true,
            'rol_id' => $rol->id_rol,
        ]);
    }
}
