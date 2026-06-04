<?php

namespace App\Models;

use Database\Factories\FamiliaFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable(['direccion', 'telefono', 'puntaje_prioridad', 'prioridad_social', 'estado_lista', 'fecha_ingreso', 'activa', 'registrado_por'])]
class Familia extends Model
{
    /** @use HasFactory<FamiliaFactory> */
    use HasFactory;

    protected $fillable = ['direccion', 'telefono', 'puntaje_prioridad', 'prioridad_social', 'estado_lista', 'fecha_ingreso', 'activa', 'registrado_por'];

    protected $table = 'familias';

    protected $primaryKey = 'id_familia';

    protected function casts(): array
    {
        return [
            'fecha_ingreso' => 'date',
            'activa' => 'boolean',
            'puntaje_prioridad' => 'integer',
        ];
    }

    public function registradoPor(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'registrado_por', 'id_usuario');
    }

    public function integrantes(): HasMany
    {
        return $this->hasMany(Integrante::class, 'familia_id', 'id_familia');
    }

    public function donaciones(): HasMany
    {
        return $this->hasMany(Donacion::class, 'familia_id', 'id_familia');
    }

    public function pedidosEspeciales(): HasMany
    {
        return $this->hasMany(PedidoEspecial::class, 'familia_id', 'id_familia');
    }

    public function visitasDomiciliarias(): HasMany
    {
        return $this->hasMany(VisitaDomiciliaria::class, 'familia_id', 'id_familia');
    }

    public function registrosAsistencia(): HasMany
    {
        return $this->hasMany(RegistroAsistencia::class, 'familia_id', 'id_familia');
    }
}
