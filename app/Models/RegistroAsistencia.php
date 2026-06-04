<?php

namespace App\Models;

use Database\Factories\RegistroAsistenciaFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['familia_id', 'fecha', 'estado', 'registrado_por'])]
class RegistroAsistencia extends Model
{
    /** @use HasFactory<RegistroAsistenciaFactory> */
    use HasFactory;

    protected $fillable = ['familia_id', 'fecha', 'estado', 'registrado_por'];

    protected $table = 'registros_asistencia';

    protected $primaryKey = 'id_registro_asistencia';

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

    public function registradoPor(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'registrado_por', 'id_usuario');
    }
}
