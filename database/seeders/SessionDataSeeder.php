<?php

namespace Database\Seeders;

use App\Models\Comision;
use App\Models\Familia;
use App\Models\Integrante;
use Illuminate\Database\Seeder;
use Carbon\CarbonPeriod;
use Illuminate\Support\Facades\DB;

class SessionDataSeeder extends Seeder
{
    public function run(): void
    {
        $now = now();

        $comisiones = collect([
            ['nombre' => 'Costura', 'descripcion' => 'Comision de Costura'],
            ['nombre' => 'Cocina', 'descripcion' => 'Comision de Cocina'],
            ['nombre' => 'Actividades', 'descripcion' => 'Actividades con ninos'],
            ['nombre' => 'Lectoescritura', 'descripcion' => 'Comision de alfabetizacion'],
            ['nombre' => 'Ropero', 'descripcion' => 'Subcomision de ropero'],
        ])->mapWithKeys(function (array $data) use ($now): array {
            $comision = Comision::query()->updateOrCreate(
                ['nombre' => $data['nombre']],
                [
                    'activa' => true,
                    'descripcion' => $data['descripcion'],
                    'encargado' => 1,
                    'updated_at' => $now,
                ]
            );

            return [$data['nombre'] => $comision];
        });

        DB::transaction(function () use ($comisiones, $now): void {
            DB::table('participacion_comision')->delete();
            DB::table('registros_asistencia')->delete();

            $integrantes = Integrante::query()
                ->get(['id_integrante', 'nombre', 'apellido'])
                ->mapWithKeys(fn ($integrante) => [
                    $integrante->nombre.' '.$integrante->apellido => $integrante->id_integrante,
                ]);

            $participaciones = [
                ['fecha_inicio' => '2026-06-04', 'estado' => true, 'observaciones' => 'Alta', 'integrante' => 'Juan Perez', 'comision' => 'Costura'],
                ['fecha_inicio' => '2026-01-03', 'estado' => true, 'observaciones' => 'Alta de participacion', 'integrante' => 'Homer Simpson', 'comision' => 'Costura'],
                ['fecha_inicio' => '2026-01-17', 'estado' => true, 'observaciones' => 'Alta de participacion', 'integrante' => 'Marge Simpson', 'comision' => 'Cocina'],
                ['fecha_inicio' => '2026-02-07', 'estado' => true, 'observaciones' => 'Alta de participacion', 'integrante' => 'Bart Simpson', 'comision' => 'Actividades'],
                ['fecha_inicio' => '2026-02-21', 'estado' => true, 'observaciones' => 'Alta de participacion', 'integrante' => 'Ned Flanders', 'comision' => 'Lectoescritura'],
                ['fecha_inicio' => '2026-03-14', 'estado' => true, 'observaciones' => 'Alta de participacion', 'integrante' => 'Kirk Van Houten', 'comision' => 'Ropero'],
                ['fecha_inicio' => '2026-04-11', 'estado' => false, 'observaciones' => 'Baja posterior', 'integrante' => 'Clancy Wiggum', 'comision' => 'Costura'],
                ['fecha_inicio' => '2026-05-16', 'estado' => true, 'observaciones' => 'Alta de participacion', 'integrante' => 'Julius Hibbert', 'comision' => 'Cocina'],
                ['fecha_inicio' => '2026-06-27', 'estado' => false, 'observaciones' => 'Baja posterior', 'integrante' => 'Bernice Hibbert', 'comision' => 'Actividades'],
            ];

            $rows = [];

            foreach ($participaciones as $participacion) {
                $integranteId = $integrantes[$participacion['integrante']] ?? null;
                $comisionId = $comisiones[$participacion['comision']]->id_comision ?? null;

                if ($integranteId === null || $comisionId === null) {
                    continue;
                }

                $rows[] = [
                    'fecha_inicio' => $participacion['fecha_inicio'],
                    'estado' => $participacion['estado'],
                    'observaciones' => $participacion['observaciones'],
                    'integrante_id' => $integranteId,
                    'comision_id' => $comisionId,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }

            if ($rows !== []) {
                DB::table('participacion_comision')->insert($rows);
            }

            $familias = Familia::query()->orderBy('id_familia')->get(['id_familia']);
            $saturdays = collect(CarbonPeriod::create('2026-01-03', '1 week', '2026-06-27'))
                ->map(fn ($date) => $date->toDateString())
                ->all();

            $attendanceRows = [];

            foreach ($saturdays as $fecha) {
                foreach ($familias as $familia) {
                    $attendanceRows[] = [
                        'familia_id' => $familia->id_familia,
                        'fecha' => $fecha,
                        'estado' => $this->estadoDeterministico($familia->id_familia, $fecha),
                        'registrado_por' => 1,
                        'created_at' => $now,
                        'updated_at' => $now,
                    ];
                }
            }

            $attendanceRows = array_merge($attendanceRows, [
                [
                    'familia_id' => 1,
                    'fecha' => '2026-06-04',
                    'estado' => 'presente',
                    'registrado_por' => 1,
                    'created_at' => $now,
                    'updated_at' => $now,
                ],
                [
                    'familia_id' => 2,
                    'fecha' => '2026-06-04',
                    'estado' => 'ausente',
                    'registrado_por' => 1,
                    'created_at' => $now,
                    'updated_at' => $now,
                ],
                [
                    'familia_id' => 6,
                    'fecha' => '2026-06-04',
                    'estado' => 'presente',
                    'registrado_por' => 1,
                    'created_at' => $now,
                    'updated_at' => $now,
                ],
            ]);

            DB::table('registros_asistencia')->insert($attendanceRows);
        });
    }

    private function estadoDeterministico(int $familiaId, string $fecha): string
    {
        $seed = sprintf('%u', crc32($familiaId.'|'.$fecha));

        return ((int) $seed % 2 === 0) ? 'presente' : 'ausente';
    }
}
