<?php

namespace Database\Seeders;

use App\Models\Comision;
use App\Models\Familia;
use App\Models\Integrante;
use App\Models\Permiso;
use App\Models\Rol;
use App\Models\Usuario;
use Illuminate\Database\Seeder;
use Carbon\CarbonPeriod;
use Illuminate\Support\Facades\DB;

class SessionDataSeeder extends Seeder
{
    public function run(): void
    {
        $now = now();

        $this->seedComisionPermissions();

        $adminUser = Usuario::query()->firstWhere('email', 'admin@example.com');

        if ($adminUser === null) {
            return;
        }

        $comisiones = collect([
            ['nombre' => 'Costura', 'descripcion' => 'Comision de Costura'],
            ['nombre' => 'Cocina', 'descripcion' => 'Comision de Cocina'],
            ['nombre' => 'Actividades', 'descripcion' => 'Actividades con ninos'],
            ['nombre' => 'Lectoescritura', 'descripcion' => 'Comision de alfabetizacion'],
            ['nombre' => 'Ropero', 'descripcion' => 'Subcomision de ropero'],
        ])->mapWithKeys(function (array $data) use ($now, $adminUser): array {
            $comision = Comision::query()->updateOrCreate(
                ['nombre' => $data['nombre']],
                [
                    'activa' => true,
                    'descripcion' => $data['descripcion'],
                    'encargado' => $adminUser->id_usuario,
                    'updated_at' => $now,
                ]
            );

            return [$data['nombre'] => $comision];
        });

        DB::transaction(function () use ($comisiones, $now, $adminUser): void {
            DB::table('participacion_comision')->delete();
            DB::table('registros_asistencia')->delete();

            $integrantes = Integrante::query()
                ->get(['id_integrante', 'nombre', 'apellido'])
                ->mapWithKeys(fn ($integrante) => [
                    $integrante->nombre.' '.$integrante->apellido => $integrante->id_integrante,
                ]);

            $participaciones = [
                ['fecha_inicio' => '2026-06-04', 'estado' => 'activo', 'observaciones' => 'Alta', 'integrante' => 'Juan Perez', 'comision' => 'Costura'],
                ['fecha_inicio' => '2026-01-03', 'estado' => 'activo', 'observaciones' => 'Alta de participacion', 'integrante' => 'Homer Simpson', 'comision' => 'Costura'],
                ['fecha_inicio' => '2026-01-17', 'estado' => 'activo', 'observaciones' => 'Alta de participacion', 'integrante' => 'Marge Simpson', 'comision' => 'Cocina'],
                ['fecha_inicio' => '2026-02-07', 'estado' => 'activo', 'observaciones' => 'Alta de participacion', 'integrante' => 'Bart Simpson', 'comision' => 'Actividades'],
                ['fecha_inicio' => '2026-02-21', 'estado' => 'activo', 'observaciones' => 'Alta de participacion', 'integrante' => 'Ned Flanders', 'comision' => 'Lectoescritura'],
                ['fecha_inicio' => '2026-03-14', 'estado' => 'activo', 'observaciones' => 'Alta de participacion', 'integrante' => 'Kirk Van Houten', 'comision' => 'Ropero'],
                ['fecha_inicio' => '2026-04-11', 'estado' => 'inactivo', 'observaciones' => 'Baja posterior', 'integrante' => 'Clancy Wiggum', 'comision' => 'Costura'],
                ['fecha_inicio' => '2026-05-16', 'estado' => 'activo', 'observaciones' => 'Alta de participacion', 'integrante' => 'Julius Hibbert', 'comision' => 'Cocina'],
                ['fecha_inicio' => '2026-06-27', 'estado' => 'inactivo', 'observaciones' => 'Baja posterior', 'integrante' => 'Bernice Hibbert', 'comision' => 'Actividades'],
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

            Familia::query()->get()->each->sincronizarParticipacionComision();

            $familias = Familia::query()->orderBy('id_familia')->get(['id_familia']);
            $saturdays = collect(CarbonPeriod::create('2026-01-03', '1 week', '2026-06-27'))
                ->map(fn ($date) => $date->toDateString())
                ->all();

            $familiaIds = $familias->pluck('id_familia');

            $attendanceRows = [];

            foreach ($saturdays as $fecha) {
                foreach ($familiaIds as $familiaId) {
                    $attendanceRows[] = [
                        'familia_id' => $familiaId,
                        'fecha' => $fecha,
                        'estado' => $this->estadoDeterministico($familiaId, $fecha),
                        'registrado_por' => $adminUser->id_usuario,
                        'created_at' => $now,
                        'updated_at' => $now,
                    ];
                }
            }

            $firstFamiliaId = $familiaIds->first();
            $secondFamiliaId = $familiaIds->skip(1)->first();
            $thirdFamiliaId = $familiaIds->skip(2)->first();

            $extraRows = [];

            if ($firstFamiliaId !== null) {
                $extraRows[] = [
                    'familia_id' => $firstFamiliaId,
                    'fecha' => '2026-06-04',
                    'estado' => 'presente',
                    'registrado_por' => $adminUser->id_usuario,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }

            if ($secondFamiliaId !== null) {
                $extraRows[] = [
                    'familia_id' => $secondFamiliaId,
                    'fecha' => '2026-06-04',
                    'estado' => 'ausente',
                    'registrado_por' => $adminUser->id_usuario,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }

            if ($thirdFamiliaId !== null) {
                $extraRows[] = [
                    'familia_id' => $thirdFamiliaId,
                    'fecha' => '2026-06-04',
                    'estado' => 'presente',
                    'registrado_por' => $adminUser->id_usuario,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }

            $attendanceRows = array_merge($attendanceRows, $extraRows);

            DB::table('registros_asistencia')->insert($attendanceRows);
        });
    }

    private function seedComisionPermissions(): void
    {
        $adminRole = Rol::query()->firstWhere('nombre', 'Administrador');

        $permisosData = [
            ['nombre' => 'Ver familias', 'modulo' => 'Familias'],
            ['nombre' => 'Gestionar familias', 'modulo' => 'Familias'],
            ['nombre' => 'Gestionar listas', 'modulo' => 'Familias'],
            ['nombre' => 'Ver comisiones', 'modulo' => 'Comisiones'],
            ['nombre' => 'Gestionar comisiones', 'modulo' => 'Comisiones'],
        ];

        foreach ($permisosData as $data) {
            $permiso = Permiso::query()->firstOrCreate(
                ['nombre' => $data['nombre']],
                ['modulo' => $data['modulo']],
            );

            if ($adminRole !== null && ! $adminRole->permisos()->where('permiso_id', $permiso->id_permiso)->exists()) {
                $adminRole->permisos()->attach($permiso->id_permiso);
            }
        }
    }

    private function estadoDeterministico(int $familiaId, string $fecha): string
    {
        $seed = sprintf('%u', crc32($familiaId.'|'.$fecha));

        return ((int) $seed % 2 === 0) ? 'presente' : 'ausente';
    }
}
