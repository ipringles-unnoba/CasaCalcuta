<?php

namespace Database\Seeders;

use App\Models\Permiso;
use App\Models\Rol;
use App\Models\Usuario;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $rol = Rol::query()->firstOrCreate(
            ['nombre' => 'Administrador'],
            ['descripcion' => 'Rol con acceso total al sistema']
        );

        $permisos = collect([
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Gestionar usuarios'],
                ['modulo' => 'usuarios']
            ),
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Gestionar roles'],
                ['modulo' => 'roles']
            ),
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Gestionar permisos'],
                ['modulo' => 'permisos']
            ),
        ]);

        $usuario = Usuario::query()->updateOrCreate(
            ['email' => 'admin@example.com'],
            [
                'nombre' => 'Admin',
                'apellido' => 'Sistema',
                'contrasena' => Hash::make('password'),
                'activo' => true,
                'rol_id' => $rol->id_rol,
            ]
        );

        $rol->permisos()->syncWithoutDetaching($permisos->pluck('id_permiso'));
    }
}
