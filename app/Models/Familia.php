<?php

namespace App\Models;

use Database\Factories\FamiliaFactory;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasManyThrough;

#[Fillable(['direccion', 'telefono', 'puntaje_prioridad', 'prioridad_social', 'estado_lista', 'fecha_ingreso', 'activa', 'registrado_por', 'referente_id', 'situacion_alimentaria', 'frecuencia_asistencia', 'participacion_merendero', 'evaluado_por', 'fecha_ultima_evaluacion'])]
class Familia extends Model
{
    /** @use HasFactory<FamiliaFactory> */
    use HasFactory;

    private const SITUACION_ALIMENTARIA_PUNTAJES = [
        'sin_urgencia' => 0,
        'moderada' => 2,
        'urgente' => 3,
    ];

    private const FRECUENCIA_ASISTENCIA_PUNTAJES = [
        'ocasional' => 0,
        'semanal' => 1,
        'mas_de_una_vez' => 2,
    ];

    private const PARTICIPACION_MERENDERO_PUNTAJES = [
        'no_participa' => 0,
        'ocasional' => 1,
        'activa' => 2,
    ];

    protected $fillable = ['direccion', 'telefono', 'puntaje_prioridad', 'prioridad_social', 'estado_lista', 'fecha_ingreso', 'activa', 'registrado_por', 'referente_id', 'situacion_alimentaria', 'frecuencia_asistencia', 'participacion_merendero', 'evaluado_por', 'fecha_ultima_evaluacion'];

    protected $appends = ['porciones_comida', 'ausentismo_critico', 'puntaje_menores', 'puntaje_alimentacion', 'puntaje_asistencia', 'puntaje_participacion'];

    protected $table = 'familias';

    protected $primaryKey = 'id_familia';

    protected function casts(): array
    {
        return [
            'fecha_ingreso' => 'date',
            'activa' => 'boolean',
            'puntaje_prioridad' => 'integer',
            'fecha_ultima_evaluacion' => 'date',
        ];
    }

    protected static function booted(): void
    {
        static::saving(function (Familia $familia): void {
            if ($familia->tieneParticipacionComisionActiva()) {
                $familia->forceFill([
                    'participacion_merendero' => 'activa',
                    'estado_lista' => 'PRINCIPAL',
                ]);
            }
        });
    }

    protected function porcionesComida(): Attribute
    {
        return Attribute::make(
            get: fn (): int => $this->relationLoaded('integrantes') ? $this->integrantes->count() : $this->integrantes()->count(),
        );
    }

    protected function ausentismoCritico(): Attribute
    {
        return Attribute::make(
            get: fn (): bool => mb_strtoupper((string) $this->estado_lista) === 'PRINCIPAL'
                && $this->currentAbsenceStreak()['count'] >= $this->ausentismoCriticoThreshold(),
        );
    }

    protected function puntajeMenores(): Attribute
    {
        return Attribute::make(
            get: fn (): int => $this->calcularPuntajeMenoresInterno(),
        );
    }

    protected function puntajeAlimentacion(): Attribute
    {
        return Attribute::make(
            get: fn (): int => self::SITUACION_ALIMENTARIA_PUNTAJES[$this->situacion_alimentaria ?? 'sin_urgencia'] ?? 0,
        );
    }

    protected function puntajeAsistencia(): Attribute
    {
        return Attribute::make(
            get: fn (): int => self::FRECUENCIA_ASISTENCIA_PUNTAJES[$this->frecuencia_asistencia ?? 'ocasional'] ?? 0,
        );
    }

    protected function puntajeParticipacion(): Attribute
    {
        return Attribute::make(
            get: fn (): int => self::PARTICIPACION_MERENDERO_PUNTAJES[$this->participacionMerenderoEfectiva()] ?? 0,
        );
    }

    public function registradoPor(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'registrado_por', 'id_usuario');
    }

    public function referente(): BelongsTo
    {
        return $this->belongsTo(Integrante::class, 'referente_id', 'id_integrante');
    }

    public function evaluadoPor(): BelongsTo
    {
        return $this->belongsTo(Usuario::class, 'evaluado_por', 'id_usuario');
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

    public function participacionesComision(): HasManyThrough
    {
        return $this->hasManyThrough(
            ParticipacionComision::class,
            Integrante::class,
            'familia_id',
            'integrante_id',
            'id_familia',
            'id_integrante'
        );
    }

    public function tieneParticipacionComisionActiva(): bool
    {
        return $this->participacionesComision()->where('estado', 'activo')->exists();
    }

    public function sincronizarParticipacionComision(): self
    {
        if (! $this->tieneParticipacionComisionActiva()) {
            return $this->refresh();
        }

        if (
            $this->participacion_merendero === 'activa'
            && mb_strtoupper((string) $this->estado_lista) === 'PRINCIPAL'
        ) {
            return $this->refresh();
        }

        $this->forceFill([
            'participacion_merendero' => 'activa',
            'estado_lista' => 'PRINCIPAL',
        ])->save();

        return $this->refresh();
    }

    public function recalcular_puntaje_menores(): self
    {
        // El puntaje ahora se calcula al leer; se conserva por compatibilidad.
        return $this->refresh();
    }

    private function currentAbsenceStreak(): array
    {
        $count = 0;
        $startDate = null;

        foreach ($this->registrosAsistencia()
            ->orderByDesc('fecha')
            ->orderByDesc('id_registro_asistencia')
            ->get() as $registroAsistencia) {
            if (mb_strtolower($registroAsistencia->estado) !== 'ausente') {
                break;
            }

            $count++;
            $startDate = $registroAsistencia->fecha instanceof \Illuminate\Support\Carbon
                ? $registroAsistencia->fecha->toDateString()
                : (string) $registroAsistencia->fecha;
        }

        return [
            'count' => $count,
            'start_date' => $startDate,
        ];
    }

    private function ausentismoCriticoThreshold(): int
    {
        return max(1, (int) env('AUSENTISMO_CRITICO', 3));
    }

    private function calcularPuntajeMenoresInterno(): int
    {
        $cantidadMenores = $this->integrantes()
            ->get()
            ->filter(fn (Integrante $integrante): bool => $integrante->categoria_etaria === 'MENOR')
            ->count();

        return match (true) {
            $cantidadMenores === 0 => 0,
            $cantidadMenores <= 2 => 1,
            default => 2,
        };
    }

    private function participacionMerenderoEfectiva(): string
    {
        if ($this->tieneParticipacionComisionActiva()) {
            return 'activa';
        }

        return (string) ($this->participacion_merendero ?? 'no_participa');
    }
}
