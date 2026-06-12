<?php

namespace Tests\Feature;

use App\Models\Rol;
use Database\Seeders\DatabaseSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class DatabaseSeederTest extends TestCase
{
    use RefreshDatabase;

    public function test_roles_receive_the_expected_permissions(): void
    {
        $this->app->make(DatabaseSeeder::class)->seedAccessControl();

        $admin = Rol::query()->with('permisos')->firstWhere('nombre', 'Administrador');
        $coordinador = Rol::query()->with('permisos')->firstWhere('nombre', 'Coordinador');
        $encargado = Rol::query()->with('permisos')->firstWhere('nombre', 'Encargado');
        $ayudante = Rol::query()->with('permisos')->firstWhere('nombre', 'Ayudante');

        $this->assertSame(
            ['Evaluar prioridad social', 'Gestionar listas', 'Gestionar notificaciones', 'Gestionar permisos', 'Gestionar roles', 'Gestionar usuarios', 'Poner asistencia', 'Ver familias', 'Ver usuarios'],
            $admin->permisos->pluck('nombre')->sort()->values()->all()
        );

        $this->assertSame(
            ['Evaluar prioridad social', 'Gestionar listas', 'Gestionar notificaciones', 'Gestionar usuarios', 'Poner asistencia', 'Ver familias', 'Ver usuarios'],
            $coordinador->permisos->pluck('nombre')->sort()->values()->all()
        );

        $this->assertSame(
            ['Evaluar prioridad social', 'Poner asistencia', 'Ver familias', 'Ver usuarios'],
            $encargado->permisos->pluck('nombre')->sort()->values()->all()
        );

        $this->assertSame(
            ['Ver familias'],
            $ayudante->permisos->pluck('nombre')->sort()->values()->all()
        );
    }
}
