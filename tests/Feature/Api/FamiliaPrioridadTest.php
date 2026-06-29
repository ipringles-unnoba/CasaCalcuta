<?php

namespace Tests\Feature\Api;

use App\Models\Familia;
use App\Models\Integrante;
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

    public function test_evaluar_prioridad_uses_business_criteria_and_moves_to_principal_when_validated(): void
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

        $this->actingAs($user, 'api')
            ->postJson('/api/familias/' . $familia->id_familia . '/evaluar-prioridad', [
                'situacion_alimentaria' => 'moderada',
                'frecuencia_asistencia' => 'semanal',
                'participacion_merendero' => 'activa',
                'participacion_activa_validada' => true,
            ])
            ->assertOk()
            ->assertJsonPath('situacion_alimentaria', 'moderada')
            ->assertJsonPath('frecuencia_asistencia', 'semanal')
            ->assertJsonPath('participacion_merendero', 'activa')
            ->assertJsonPath('participacion_activa_validada', true)
            ->assertJsonPath('puntaje_menores', 1)
            ->assertJsonPath('puntaje_alimentacion', 2)
            ->assertJsonPath('puntaje_asistencia', 1)
            ->assertJsonPath('puntaje_participacion', 2)
            ->assertJsonPath('puntaje_prioridad', 6)
            ->assertJsonPath('prioridad_social', 'muy_alta')
            ->assertJsonPath('estado_lista', 'PRINCIPAL');

        $this->assertDatabaseHas('familias', [
            'id_familia' => $familia->id_familia,
            'situacion_alimentaria' => 'moderada',
            'frecuencia_asistencia' => 'semanal',
            'participacion_merendero' => 'activa',
            'participacion_activa_validada' => true,
            'puntaje_prioridad' => 6,
            'prioridad_social' => 'muy_alta',
            'estado_lista' => 'PRINCIPAL',
        ]);
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
