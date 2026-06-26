<?php

namespace App\Models;

use Database\Factories\FamiliaFactory;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

#[Fillable(['direccion', 'telefono', 'puntaje_prioridad', 'prioridad_social', 'estado_lista', 'fecha_ingreso', 'activa', 'registrado_por', 'referente_id', 'puntaje_menores', 'puntaje_alimentacion', 'puntaje_asistencia', 'puntaje_participacion', 'evaluado_por', 'fecha_ultima_evaluacion'])]
class Familia extends Model
{
    /** @use HasFactory<FamiliaFactory> */
    use HasFactory;

    protected $fillable = ['direccion', 'telefono', 'puntaje_prioridad', 'prioridad_social', 'estado_lista', 'fecha_ingreso', 'activa', 'registrado_por', 'referente_id', 'puntaje_menores', 'puntaje_alimentacion', 'puntaje_asistencia', 'puntaje_participacion', 'evaluado_por', 'fecha_ultima_evaluacion'];

    protected $appends = ['porciones_comida', 'ausentismo_critico'];

    protected $table = 'familias';

    protected $primaryKey = 'id_familia';

    protected function casts(): array
    {
        return [
            'fecha_ingreso' => 'date',
            'activa' => 'boolean',
            'puntaje_prioridad' => 'integer',
            'puntaje_menores' => 'integer',
            'puntaje_alimentacion' => 'integer',
            'puntaje_asistencia' => 'integer',
            'puntaje_participacion' => 'integer',
            'fecha_ultima_evaluacion' => 'date',
        ];
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

    public function recalcular_puntaje_menores(): self
    {
        $puntajeMenores = $this->integrantes()
            ->get()
            ->filter(fn (Integrante $integrante): bool => $integrante->categoria_etaria === 'MENOR')
            ->count();

        $this->forceFill(['puntaje_menores' => $puntajeMenores])->save();

        return $this->refresh();
    }
}
