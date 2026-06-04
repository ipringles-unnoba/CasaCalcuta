<?php

namespace App\Models;

use Database\Factories\PedidoEspecialFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['descripcion', 'estado', 'fecha_carga', 'registrado_por', 'familia_id'])]
class PedidoEspecial extends Model
{
    /** @use HasFactory<PedidoEspecialFactory> */
    use HasFactory;

    protected $fillable = ['descripcion', 'estado', 'fecha_carga', 'registrado_por', 'familia_id'];

    protected $table = 'pedidos_especiales';

    protected $primaryKey = 'id_pedido_especial';

    protected function casts(): array
    {
        return [
            'fecha_carga' => 'date',
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
