<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Database\Factories\PermisoFactory;

#[Fillable(['nombre', 'modulo'])]
class Permiso extends Model
{
    /** @use HasFactory<PermisoFactory> */
    use HasFactory;

    protected $table = 'permisos';

    protected $primaryKey = 'id_permiso';

    public function roles(): BelongsToMany
    {
        return $this->belongsToMany(Rol::class, 'rol_permiso', 'permiso_id', 'rol_id');
    }
}
