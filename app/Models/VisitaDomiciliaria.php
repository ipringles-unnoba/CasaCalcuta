<?php

namespace App\Models;

use Database\Factories\VisitaDomiciliariaFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

#[Fillable(['fecha', 'observaciones', 'familia_id'])]
class VisitaDomiciliaria extends Model
{
    /** @use HasFactory<VisitaDomiciliariaFactory> */
    use HasFactory;

    protected $fillable = ['fecha', 'observaciones', 'familia_id'];

    protected $table = 'visitas_domiciliarias';

    protected $primaryKey = 'id_visita_domiciliaria';

    protected function casts(): array
    {
        return [
            'fecha' => 'date',
        ];
    }

    public function familia(): BelongsTo
    {
        return $this->belongsTo(Familia::class, 'familia_id', 'id_familia');
    }

    public function usuarios(): BelongsToMany
    {
        return $this->belongsToMany(Usuario::class, 'visita_domiciliaria_usuario', 'visita_domiciliaria_id', 'usuario_visitador');
    }
}
