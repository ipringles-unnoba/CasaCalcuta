<?php

namespace App\Models;

use Database\Factories\ParticipacionComisionFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['fecha_inicio', 'estado', 'observaciones', 'integrante_id', 'comision_id'])]
class ParticipacionComision extends Model
{
    /** @use HasFactory<ParticipacionComisionFactory> */
    use HasFactory;

    protected $fillable = ['fecha_inicio', 'estado', 'observaciones', 'integrante_id', 'comision_id'];

    protected $table = 'participacion_comision';

    protected $primaryKey = 'id_participacion_comision';

    protected function casts(): array
    {
        return [
            'fecha_inicio' => 'date',
            'estado' => 'boolean',
        ];
    }

    public function integrante(): BelongsTo
    {
        return $this->belongsTo(Integrante::class, 'integrante_id', 'id_integrante');
    }

    public function comision(): BelongsTo
    {
        return $this->belongsTo(Comision::class, 'comision_id', 'id_comision');
    }
}
