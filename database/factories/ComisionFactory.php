<?php

namespace Database\Factories;

use App\Models\Comision;
use App\Models\Usuario;
use Illuminate\Database\Eloquent\Factories\Factory;

class ComisionFactory extends Factory
{
    protected $model = Comision::class;

    public function definition(): array
    {
        return [
            'nombre' => fake()->unique()->word(),
            'activa' => fake()->boolean(),
            'descripcion' => fake()->sentence(),
            'encargado' => Usuario::factory(),
        ];
    }
}
