<?php

namespace App\Models;

use Database\Factories\ComisionFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable(['nombre', 'activa', 'descripcion', 'encargado'])]
class Comision extends Model
{
    /** @use HasFactory<ComisionFactory> */
    use HasFactory;

    protected $fillable = ['nombre', 'activa', 'descripcion', 'encargado'];

    protected $table = 'comisiones';

    protected $primaryKey = 'id_comision';

    protected function casts(): array
    {
        return [
            'activa' => 'boolean',
        ];
    }

    public function encargado(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'encargado', 'id_usuario');
    }

    public function participaciones(): HasMany
    {
        return $this->hasMany(ParticipacionComision::class, 'comision_id', 'id_comision');
    }
}
