<?php

namespace Tests\Feature\Api;

use App\Models\Familia;
use App\Models\Rol;
use App\Models\VisitaDomiciliaria;
use App\Models\Usuario;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class UsuarioTest extends TestCase
{
    use RefreshDatabase;

    public function test_usuarios_endpoint_requires_authentication(): void
    {
        $this->getJson('/api/usuarios')->assertUnauthorized();
    }

    public function test_authenticated_user_can_list_usuarios(): void
    {
        $rol = Rol::factory()->create();
        Usuario::factory()->count(2)->create(['rol_id' => $rol->id_rol]);

        $user = Usuario::factory()->create(['rol_id' => $rol->id_rol]);
        $token = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->json('access_token');

        $this->withHeader('Authorization', 'Bearer '.$token)
            ->getJson('/api/usuarios')
            ->assertOk()
            ->assertJsonStructure(['data', 'links', 'meta']);
    }

    public function test_authenticated_user_can_create_usuario(): void
    {
        $rol = Rol::factory()->create();
        $user = Usuario::factory()->create(['rol_id' => $rol->id_rol]);

        $token = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->json('access_token');

        $this->withHeader('Authorization', 'Bearer '.$token)
            ->postJson('/api/usuarios', [
                'nombre' => 'Nuevo',
                'apellido' => 'Usuario',
                'email' => 'nuevo@example.com',
                'contrasena' => 'password',
                'contrasena_confirmation' => 'password',
                'activo' => true,
                'rol_id' => $rol->id_rol,
            ])
            ->assertCreated()
            ->assertJsonPath('data.email', 'nuevo@example.com');
    }

    public function test_usuario_creation_returns_spanish_password_confirmation_error(): void
    {
        $rol = Rol::factory()->create();
        $user = Usuario::factory()->create(['rol_id' => $rol->id_rol]);

        $token = $this->postJson('/api/auth/login', [
            'email' => $user->email,
            'password' => 'password',
        ])->json('access_token');

        $this->withHeader('Authorization', 'Bearer '.$token)
            ->postJson('/api/usuarios', [
                'nombre' => 'Nuevo',
                'apellido' => 'Usuario',
                'email' => 'nuevo2@example.com',
                'contrasena' => 'password',
                'contrasena_confirmation' => 'otra',
                'activo' => true,
                'rol_id' => $rol->id_rol,
            ])
            ->assertStatus(422)
            ->assertJsonValidationErrors(['contrasena'])
            ->assertJsonPath('errors.contrasena.0', 'La confirmación de la contraseña no coincide.');
    }

    public function test_authenticated_user_can_delete_usuario(): void
    {
        $rol = Rol::factory()->create();
        $user = Usuario::factory()->create(['rol_id' => $rol->id_rol]);
        $usuario = Usuario::factory()->create(['rol_id' => $rol->id_rol]);

        $this->actingAs($user, 'api')
            ->deleteJson('/api/usuarios/'.$usuario->id_usuario)
            ->assertNoContent();

        $this->assertDatabaseMissing('usuarios', [
            'id_usuario' => $usuario->id_usuario,
        ]);
    }

    public function test_usuario_endpoints_do_not_expose_password(): void
    {
        $rol = Rol::factory()->create();
        $user = Usuario::factory()->create(['rol_id' => $rol->id_rol]);
        $usuario = Usuario::factory()->create(['rol_id' => $rol->id_rol]);

        $familia = Familia::query()->create([
            'direccion' => 'Prueba 123',
            'telefono' => '555-0000',
            'puntaje_prioridad' => 0,
            'prioridad_social' => 'BAJA',
            'estado_lista' => 'PRINCIPAL',
            'fecha_ingreso' => now()->toDateString(),
            'activa' => true,
            'registrado_por' => $user->id_usuario,
        ]);

        $visita = VisitaDomiciliaria::query()->create([
            'fecha' => now()->toDateString(),
            'observaciones' => 'Prueba',
            'familia_id' => $familia->id_familia,
        ]);

        $visita->usuarios()->sync([$usuario->id_usuario]);

        $this->actingAs($user, 'api')
            ->getJson('/api/usuarios')
            ->assertOk()
            ->assertJsonMissingPath('data.0.contrasena')
            ->assertJsonMissingPath('data.0.remember_token');

        $this->actingAs($user, 'api')
            ->getJson('/api/usuarios/' . $usuario->id_usuario)
            ->assertOk()
            ->assertJsonMissingPath('data.contrasena');

        $this->actingAs($user, 'api')
            ->getJson('/api/visitas-domiciliarias/' . $visita->id_visita_domiciliaria . '/usuarios')
            ->assertOk()
            ->assertJsonMissingPath('0.contrasena');
    }
}
