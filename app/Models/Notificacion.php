<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Database\Factories\NotificacionFactory;

#[Fillable(['fecha', 'motivo', 'visto'])]
class Notificacion extends Model
{
    /** @use HasFactory<NotificacionFactory> */
    use HasFactory;

    protected $fillable = ['fecha', 'motivo', 'visto'];

    protected $attributes = [
        'visto' => false,
    ];

    protected $table = 'notificaciones';

    protected $primaryKey = 'id_notificacion';

    protected function casts(): array
    {
        return [
            'fecha' => 'date',
            'visto' => 'boolean',
        ];
    }

    public function usuarios(): BelongsToMany
    {
        return $this->belongsToMany(Usuario::class, 'usuario_notificacion', 'notificacion_id', 'usuario_id');
    }
}
