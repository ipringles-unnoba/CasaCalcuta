<?php

namespace Tests\Feature\Api;

use App\Models\Rol;
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
}
