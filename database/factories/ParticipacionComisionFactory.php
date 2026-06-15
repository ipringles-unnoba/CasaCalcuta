<?php

namespace Database\Factories;

use App\Models\Comision;
use App\Models\Integrante;
use App\Models\ParticipacionComision;
use Illuminate\Database\Eloquent\Factories\Factory;

class ParticipacionComisionFactory extends Factory
{
    protected $model = ParticipacionComision::class;

    public function definition(): array
    {
        return [
            'fecha_inicio' => fake()->date(),
            'estado' => fake()->randomElement(['activo', 'inactivo', 'ocasional']),
            'observaciones' => fake()->optional()->sentence(),
            'integrante_id' => Integrante::factory(),
            'comision_id' => Comision::factory(),
        ];
    }
}
