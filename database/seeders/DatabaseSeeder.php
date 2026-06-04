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
        $roles = collect([
            Rol::query()->firstOrCreate(
                ['nombre' => 'Administrador'],
                ['descripcion' => 'Rol con acceso total al sistema']
            ),
            Rol::query()->firstOrCreate(
                ['nombre' => 'Operador'],
                ['descripcion' => 'Rol para tareas operativas']
            ),
            Rol::query()->firstOrCreate(
                ['nombre' => 'Consulta'],
                ['descripcion' => 'Rol con acceso de solo lectura']
            ),
        ]);

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
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Gestionar notificaciones'],
                ['modulo' => 'notificaciones']
            ),
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Ver usuarios'],
                ['modulo' => 'usuarios']
            ),
        ]);

        $usuarios = [
            [
                'email' => 'admin@example.com',
                'nombre' => 'Admin',
                'apellido' => 'Sistema',
                'rol' => 'Administrador',
            ],
            [
                'email' => 'operador@example.com',
                'nombre' => 'Operador',
                'apellido' => 'CasaCalcuta',
                'rol' => 'Operador',
            ],
            [
                'email' => 'consulta@example.com',
                'nombre' => 'Consulta',
                'apellido' => 'CasaCalcuta',
                'rol' => 'Consulta',
            ],
        ];

        foreach ($usuarios as $datos) {
            $rol = $roles->firstWhere('nombre', $datos['rol']);

            Usuario::query()->updateOrCreate(
                ['email' => $datos['email']],
                [
                    'nombre' => $datos['nombre'],
                    'apellido' => $datos['apellido'],
                    'contrasena' => Hash::make('password'),
                    'activo' => true,
                    'rol_id' => $rol->id_rol,
                ]
            );
        }

        $roles->firstWhere('nombre', 'Administrador')?->permisos()->syncWithoutDetaching($permisos->pluck('id_permiso'));
        $roles->firstWhere('nombre', 'Operador')?->permisos()->syncWithoutDetaching(
            $permisos->whereIn('nombre', ['Gestionar notificaciones', 'Ver usuarios'])->pluck('id_permiso')
        );
        $roles->firstWhere('nombre', 'Consulta')?->permisos()->syncWithoutDetaching(
            $permisos->where('nombre', 'Ver usuarios')->pluck('id_permiso')
        );
    }
}
