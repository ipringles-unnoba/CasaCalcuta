<?php

namespace App\Models;

use Database\Factories\AuditoriaFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['usuario_id', 'accion', 'entidad', 'entidad_id', 'fecha', 'cambios'])]
class Auditoria extends Model
{
    /** @use HasFactory<AuditoriaFactory> */
    use HasFactory;

    protected $fillable = ['usuario_id', 'accion', 'entidad', 'entidad_id', 'fecha', 'cambios'];

    protected $table = 'auditorias';

    protected $primaryKey = 'id_auditoria';

    protected function casts(): array
    {
        return [
            'fecha' => 'date',
            'entidad_id' => 'integer',
        ];
    }

    public function usuario(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'usuario_id', 'id_usuario');
    }
}
