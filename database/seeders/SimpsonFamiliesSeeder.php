<?php

namespace Database\Seeders;

use App\Models\Familia;
use App\Models\Integrante;
use App\Models\Usuario;
use Illuminate\Database\Seeder;

class SimpsonFamiliesSeeder extends Seeder
{
    public function run(): void
    {
        $adminUser = Usuario::query()->firstWhere('email', 'admin@example.com');

        if ($adminUser === null) {
            return;
        }

        $familias = [
            [
                'direccion' => '742 Evergreen Terrace',
                'telefono' => '555-0101',
                'puntaje_prioridad' => 100,
                'prioridad_social' => 'ALTA',
                'estado_lista' => 'PRINCIPAL',
                'fecha_ingreso' => '2024-01-15',
                'activa' => true,
                'integrantes' => [
                    ['nombre' => 'Homer', 'apellido' => 'Simpson', 'fecha_nacimiento' => '1956-05-12', 'tipo_documento' => 'DNI', 'numero_documento' => 'SIM-001', 'categoria_etaria' => 'ADULTO', 'referente' => true],
                    ['nombre' => 'Marge', 'apellido' => 'Simpson', 'fecha_nacimiento' => '1956-03-19', 'tipo_documento' => 'DNI', 'numero_documento' => 'SIM-002', 'categoria_etaria' => 'ADULTO', 'referente' => false],
                    ['nombre' => 'Bart', 'apellido' => 'Simpson', 'fecha_nacimiento' => '1980-04-01', 'tipo_documento' => 'DNI', 'numero_documento' => 'SIM-003', 'categoria_etaria' => 'MENOR', 'referente' => false],
                    ['nombre' => 'Lisa', 'apellido' => 'Simpson', 'fecha_nacimiento' => '1982-05-09', 'tipo_documento' => 'DNI', 'numero_documento' => 'SIM-004', 'categoria_etaria' => 'MENOR', 'referente' => false],
                    ['nombre' => 'Maggie', 'apellido' => 'Simpson', 'fecha_nacimiento' => '1988-01-12', 'tipo_documento' => 'DNI', 'numero_documento' => 'SIM-005', 'categoria_etaria' => 'BEBE', 'referente' => false],
                ],
            ],
            [
                'direccion' => '744 Evergreen Terrace',
                'telefono' => '555-0102',
                'puntaje_prioridad' => 80,
                'prioridad_social' => 'MEDIA',
                'estado_lista' => 'ESPERA',
                'fecha_ingreso' => '2024-02-10',
                'activa' => true,
                'integrantes' => [
                    ['nombre' => 'Ned', 'apellido' => 'Flanders', 'fecha_nacimiento' => '1959-02-01', 'tipo_documento' => 'DNI', 'numero_documento' => 'FLA-001', 'categoria_etaria' => 'ADULTO', 'referente' => true],
                    ['nombre' => 'Rod', 'apellido' => 'Flanders', 'fecha_nacimiento' => '1985-07-07', 'tipo_documento' => 'DNI', 'numero_documento' => 'FLA-002', 'categoria_etaria' => 'MENOR', 'referente' => false],
                    ['nombre' => 'Todd', 'apellido' => 'Flanders', 'fecha_nacimiento' => '1987-09-15', 'tipo_documento' => 'DNI', 'numero_documento' => 'FLA-003', 'categoria_etaria' => 'MENOR', 'referente' => false],
                ],
            ],
            [
                'direccion' => 'Apartment 2A, 33 Spooner Street',
                'telefono' => '555-0103',
                'puntaje_prioridad' => 60,
                'prioridad_social' => 'MEDIA',
                'estado_lista' => 'ESPERA',
                'fecha_ingreso' => '2024-03-05',
                'activa' => true,
                'integrantes' => [
                    ['nombre' => 'Kirk', 'apellido' => 'Van Houten', 'fecha_nacimiento' => '1959-08-01', 'tipo_documento' => 'DNI', 'numero_documento' => 'VAN-001', 'categoria_etaria' => 'ADULTO', 'referente' => true],
                    ['nombre' => 'Luann', 'apellido' => 'Van Houten', 'fecha_nacimiento' => '1960-10-15', 'tipo_documento' => 'DNI', 'numero_documento' => 'VAN-002', 'categoria_etaria' => 'ADULTO', 'referente' => false],
                    ['nombre' => 'Milhouse', 'apellido' => 'Van Houten', 'fecha_nacimiento' => '1980-02-20', 'tipo_documento' => 'DNI', 'numero_documento' => 'VAN-003', 'categoria_etaria' => 'MENOR', 'referente' => false],
                ],
            ],
            [
                'direccion' => 'Wiggum Residence',
                'telefono' => '555-0104',
                'puntaje_prioridad' => 50,
                'prioridad_social' => 'BAJA',
                'estado_lista' => 'INACTIVA',
                'fecha_ingreso' => '2024-04-20',
                'activa' => true,
                'integrantes' => [
                    ['nombre' => 'Clancy', 'apellido' => 'Wiggum', 'fecha_nacimiento' => '1954-01-21', 'tipo_documento' => 'DNI', 'numero_documento' => 'WIG-001', 'categoria_etaria' => 'ADULTO', 'referente' => true],
                    ['nombre' => 'Sarah', 'apellido' => 'Wiggum', 'fecha_nacimiento' => '1956-11-02', 'tipo_documento' => 'DNI', 'numero_documento' => 'WIG-002', 'categoria_etaria' => 'ADULTO', 'referente' => false],
                    ['nombre' => 'Ralph', 'apellido' => 'Wiggum', 'fecha_nacimiento' => '1980-02-28', 'tipo_documento' => 'DNI', 'numero_documento' => 'WIG-003', 'categoria_etaria' => 'MENOR', 'referente' => false],
                ],
            ],
            [
                'direccion' => 'Hibbert Residence',
                'telefono' => '555-0105',
                'puntaje_prioridad' => 70,
                'prioridad_social' => 'MEDIA',
                'estado_lista' => 'PRINCIPAL',
                'fecha_ingreso' => '2024-05-11',
                'activa' => true,
                'integrantes' => [
                    ['nombre' => 'Julius', 'apellido' => 'Hibbert', 'fecha_nacimiento' => '1952-09-18', 'tipo_documento' => 'DNI', 'numero_documento' => 'HIB-001', 'categoria_etaria' => 'ADULTO', 'referente' => true],
                    ['nombre' => 'Bernice', 'apellido' => 'Hibbert', 'fecha_nacimiento' => '1954-06-24', 'tipo_documento' => 'DNI', 'numero_documento' => 'HIB-002', 'categoria_etaria' => 'ADULTO', 'referente' => false],
                ],
            ],
        ];

        foreach ($familias as $familiaData) {
            $integrantes = $familiaData['integrantes'];
            unset($familiaData['integrantes']);

            $referenteId = null;

            $familia = Familia::query()->updateOrCreate(
                ['direccion' => $familiaData['direccion']],
                $familiaData + ['registrado_por' => $adminUser->id_usuario]
            );

            foreach ($integrantes as $integranteData) {
                $integrante = Integrante::query()->updateOrCreate(
                    ['numero_documento' => $integranteData['numero_documento']],
                    $integranteData + ['familia_id' => $familia->id_familia]
                );

                if ($integranteData['referente']) {
                    $referenteId = $integrante->id_integrante;
                }
            }

            $familia->forceFill(['referente_id' => $referenteId])->save();
        }
    }
}
