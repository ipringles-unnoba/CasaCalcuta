<?php

namespace App\Models;

use Database\Factories\IntegranteFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

#[Fillable(['nombre', 'apellido', 'fecha_nacimiento', 'tipo_documento', 'numero_documento', 'categoria_etaria', 'referente', 'familia_id'])]
class Integrante extends Model
{
    /** @use HasFactory<IntegranteFactory> */
    use HasFactory;

    protected $fillable = ['nombre', 'apellido', 'fecha_nacimiento', 'tipo_documento', 'numero_documento', 'categoria_etaria', 'referente', 'familia_id'];

    protected $table = 'integrantes';

    protected $primaryKey = 'id_integrante';

    protected function casts(): array
    {
        return [
            'fecha_nacimiento' => 'date',
            'referente' => 'boolean',
        ];
    }

    public function familia(): BelongsTo
    {
        return $this->belongsTo(Familia::class, 'familia_id', 'id_familia');
    }

    public function participacionesComision(): HasMany
    {
        return $this->hasMany(ParticipacionComision::class, 'integrante_id', 'id_integrante');
    }

    public function documentos(): BelongsToMany
    {
        return $this->belongsToMany(Documento::class, 'documentacion_integrante', 'integrante_id', 'documento_id');
    }
}
