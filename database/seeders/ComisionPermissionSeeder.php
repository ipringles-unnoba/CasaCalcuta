<?php

namespace Database\Seeders;

use App\Models\Permiso;
use App\Models\Rol;
use Illuminate\Database\Seeder;

class ComisionPermissionSeeder extends Seeder
{
    public function run(): void
    {
        $adminRole = Rol::query()->firstWhere('nombre', 'Administrador');
        $coordinadorRole = Rol::query()->firstWhere('nombre', 'Coordinador');

        $permisosData = [
            ['nombre' => 'Ver comisiones', 'modulo' => 'Comisiones'],
            ['nombre' => 'Gestionar comisiones', 'modulo' => 'Comisiones'],
            ['nombre' => 'Gestionar participaciones', 'modulo' => 'Comisiones'],
        ];

        $permisos = [];

        foreach ($permisosData as $data) {
            $permiso = Permiso::query()->firstOrCreate(
                ['nombre' => $data['nombre']],
                ['modulo' => $data['modulo']],
            );

            $permisos[$data['nombre']] = $permiso;
        }

        $adminPermisos = [
            $permisos['Ver comisiones']->id_permiso,
            $permisos['Gestionar comisiones']->id_permiso,
            $permisos['Gestionar participaciones']->id_permiso,
        ];

        $coordinadorPermisos = [
            $permisos['Ver comisiones']->id_permiso,
            $permisos['Gestionar participaciones']->id_permiso,
        ];

        if ($adminRole !== null) {
            $adminRole->permisos()->syncWithoutDetaching($adminPermisos);
        }

        if ($coordinadorRole !== null) {
            $coordinadorRole->permisos()->syncWithoutDetaching($coordinadorPermisos);
        }
    }
}
