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

    public function run(): void
    {
        $roles = collect([
            Rol::query()->firstOrCreate(
                ['nombre' => 'Administrador'],
                ['descripcion' => 'Rol con acceso total al sistema']
            ),
            Rol::query()->firstOrCreate(
                ['nombre' => 'Coordinador'],
                ['descripcion' => 'Responsable de la gestión de familias y listas. Autoriza el paso de lista de espera a principal y gestiona las alertas de ausentismo.']
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
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Evaluar prioridad social'],
                ['modulo' => 'priorizacion']
            ),
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Gestionar listas'],
                ['modulo' => 'familias']
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
                'email' => 'coordinador@example.com',
                'nombre' => 'Coordinador',
                'apellido' => 'CasaCalcuta',
                'rol' => 'Coordinador',
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

        $administrador = $roles->firstWhere('nombre', 'Administrador');
        $coordinador = $roles->firstWhere('nombre', 'Coordinador');

        $administrador?->permisos()->syncWithoutDetaching($permisos->pluck('id_permiso'));
        $coordinador?->permisos()->syncWithoutDetaching(
            $permisos->whereIn('nombre', [
                'Evaluar prioridad social',
                'Gestionar listas',
                'Gestionar notificaciones',
                'Ver usuarios',
            ])->pluck('id_permiso')
        );
        $roles->firstWhere('nombre', 'Operador')?->permisos()->syncWithoutDetaching(
            $permisos->whereIn('nombre', ['Gestionar notificaciones', 'Ver usuarios'])->pluck('id_permiso')
        );
        $roles->firstWhere('nombre', 'Consulta')?->permisos()->syncWithoutDetaching(
            $permisos->where('nombre', 'Ver usuarios')->pluck('id_permiso')
        );

        $this->call(SimpsonFamiliesSeeder::class);
        $this->call(SessionDataSeeder::class);
    }
}
