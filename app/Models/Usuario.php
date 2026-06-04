<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Database\Factories\UsuarioFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Attributes\Hidden;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;

#[Fillable(['nombre', 'apellido', 'email', 'contrasena', 'activo', 'rol_id'])]
#[Hidden(['contrasena', 'remember_token'])]
class Usuario extends Authenticatable implements JWTSubject
{
    /** @use HasFactory<UsuarioFactory> */
    use HasFactory, Notifiable;

    protected $fillable = ['nombre', 'apellido', 'email', 'contrasena', 'activo', 'rol_id'];

    protected $table = 'usuarios';

    protected $primaryKey = 'id_usuario';

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'contrasena' => 'hashed',
            'activo' => 'boolean',
        ];
    }

    public function getAuthPasswordName(): string
    {
        return 'contrasena';
    }

    public function rol(): BelongsTo
    {
        return $this->belongsTo(Rol::class, 'rol_id', 'id_rol');
    }

    public function familias(): HasMany
    {
        return $this->hasMany(Familia::class, 'registrado_por', 'id_usuario');
    }

    public function donaciones(): HasMany
    {
        return $this->hasMany(Donacion::class, 'registrado_por', 'id_usuario');
    }

    public function pedidosEspeciales(): HasMany
    {
        return $this->hasMany(PedidoEspecial::class, 'registrado_por', 'id_usuario');
    }

    public function comisionesEncargadas(): HasMany
    {
        return $this->hasMany(Comision::class, 'encargado', 'id_usuario');
    }

    public function registrosAsistencia(): HasMany
    {
        return $this->hasMany(RegistroAsistencia::class, 'registrado_por', 'id_usuario');
    }

    public function auditorias(): HasMany
    {
        return $this->hasMany(Auditoria::class, 'usuario_id', 'id_usuario');
    }

    public function notificaciones(): BelongsToMany
    {
        return $this->belongsToMany(Notificacion::class, 'usuario_notificacion', 'usuario_id', 'notificacion_id');
    }

    public function visitasDomiciliarias(): BelongsToMany
    {
        return $this->belongsToMany(VisitaDomiciliaria::class, 'visita_domiciliaria_usuario', 'usuario_visitador', 'visita_domiciliaria_id');
    }

    public function getJWTIdentifier(): mixed
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims(): array
    {
        return [];
    }
}
