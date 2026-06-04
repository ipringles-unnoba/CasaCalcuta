<?php

namespace App\Models;

use Database\Factories\DonacionFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['origen', 'descripcion', 'cantidad', 'unidad_medida', 'fecha_recepcion', 'registrado_por', 'familia_id'])]
class Donacion extends Model
{
    /** @use HasFactory<DonacionFactory> */
    use HasFactory;

    protected $fillable = ['origen', 'descripcion', 'cantidad', 'unidad_medida', 'fecha_recepcion', 'registrado_por', 'familia_id'];

    protected $table = 'donaciones';

    protected $primaryKey = 'id_donacion';

    protected function casts(): array
    {
        return [
            'fecha_recepcion' => 'date',
            'cantidad' => 'integer',
        ];
    }

    public function registradoPor(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'registrado_por', 'id_usuario');
    }

    public function familia(): BelongsTo
    {
        return $this->belongsTo(Familia::class, 'familia_id', 'id_familia');
    }
}
