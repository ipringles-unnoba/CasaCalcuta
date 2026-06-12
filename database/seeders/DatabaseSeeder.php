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
        $this->seedAccessControl();

        $this->call(SimpsonFamiliesSeeder::class);
        $this->call(SessionDataSeeder::class);
    }

    public function seedAccessControl(): void
    {
        $roles = collect([
            Rol::query()->firstOrCreate(
                ['nombre' => 'Administrador'],
                ['descripcion' => 'Rol con acceso total al sistema']
            ),
            Rol::query()->firstOrCreate(
                ['nombre' => 'Coordinador'],
                ['descripcion' => 'Responsable de la gestión de familias y listas.']
            ),
            Rol::query()->firstOrCreate(
                ['nombre' => 'Encargado'],
                ['descripcion' => 'Rol operativo con acceso a usuarios, familias, asistencia y evaluacion de prioridad social.']
            ),
            Rol::query()->firstOrCreate(
                ['nombre' => 'Ayudante'],
                ['descripcion' => 'Rol con acceso de solo lectura sobre familias.']
            ),
        ]);

        $permisos = collect([
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Gestionar usuarios'],
                ['modulo' => 'usuarios']
            ),
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Ver usuarios'],
                ['modulo' => 'usuarios']
            ),
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Ver familias'],
                ['modulo' => 'familias']
            ),
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Poner asistencia'],
                ['modulo' => 'asistencia']
            ),
            Permiso::query()->firstOrCreate(
                ['nombre' => 'Evaluar prioridad social'],
                ['modulo' => 'priorizacion']
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
                'nombre' => 'Encargado',
                'apellido' => 'CasaCalcuta',
                'rol' => 'Encargado',
            ],
            [
                'email' => 'consulta@example.com',
                'nombre' => 'Ayudante',
                'apellido' => 'CasaCalcuta',
                'rol' => 'Ayudante',
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
        $encargado = $roles->firstWhere('nombre', 'Encargado');
        $ayudante = $roles->firstWhere('nombre', 'Ayudante');

        $administrador?->permisos()->sync($permisos->pluck('id_permiso'));
        $coordinador?->permisos()->sync(
            $permisos->whereNotIn('nombre', ['Gestionar roles', 'Gestionar permisos'])->pluck('id_permiso')
        );
        $encargado?->permisos()->sync(
            $permisos->whereIn('nombre', [
                'Ver usuarios',
                'Ver familias',
                'Poner asistencia',
                'Evaluar prioridad social',
            ])->pluck('id_permiso')
        );
        $ayudante?->permisos()->sync(
            $permisos->whereIn('nombre', ['Ver familias'])->pluck('id_permiso')
        );
    }
}
