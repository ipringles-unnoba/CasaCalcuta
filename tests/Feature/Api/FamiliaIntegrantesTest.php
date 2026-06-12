<?php

namespace Tests\Feature\Api;

use App\Models\Familia;
use App\Models\Integrante;
use App\Models\Rol;
use App\Models\Usuario;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class FamiliaIntegrantesTest extends TestCase
{
    use RefreshDatabase;

    public function test_familia_integrantes_endpoint_returns_calculated_categoria_etaria(): void
    {
        $rol = Rol::factory()->create();
        $user = Usuario::factory()->create(['rol_id' => $rol->id_rol]);

        $familia = Familia::query()->create([
            'direccion' => 'Calle Falsa 123',
            'telefono' => '555-1234',
            'puntaje_prioridad' => 0,
            'prioridad_social' => 'BAJA',
            'estado_lista' => 'PRINCIPAL',
            'fecha_ingreso' => '2026-06-11',
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
            'fecha_nacimiento' => now()->subYears(20)->toDateString(),
            'tipo_documento' => 'DNI',
            'numero_documento' => 'DOC-002',
            'referente' => false,
            'familia_id' => $familia->id_familia,
        ]);

        $familia->recalcular_puntaje_menores();

        $this->actingAs($user, 'api')
            ->getJson('/api/familias/' . $familia->id_familia . '/integrantes')
            ->assertOk()
            ->assertJsonFragment(['nombre' => 'Menor', 'categoria_etaria' => 'MENOR'])
            ->assertJsonFragment(['nombre' => 'Adulto', 'categoria_etaria' => 'ADULTO']);

        $this->assertDatabaseHas('familias', [
            'id_familia' => $familia->id_familia,
            'puntaje_menores' => 1,
        ]);
    }
}
