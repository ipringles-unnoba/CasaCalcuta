<?php

namespace App\Models;

use Database\Factories\ParticipacionComisionFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

#[Fillable(['fecha_inicio', 'estado', 'observaciones', 'integrante_id', 'comision_id'])]
class ParticipacionComision extends Model
{
    /** @use HasFactory<ParticipacionComisionFactory> */
    use HasFactory;

    protected $fillable = ['fecha_inicio', 'estado', 'observaciones', 'integrante_id', 'comision_id'];

    protected ?int $familiaIdOriginal = null;

    protected $table = 'participacion_comision';

    protected $primaryKey = 'id_participacion_comision';

    protected function casts(): array
    {
        return [
            'fecha_inicio' => 'date',
        ];
    }

    protected static function booted(): void
    {
        static::updating(function (ParticipacionComision $participacionComision): void {
            if ($participacionComision->isDirty('integrante_id')) {
                $participacionComision->familiaIdOriginal = $participacionComision->familiaIdDeIntegrante(
                    (int) $participacionComision->getOriginal('integrante_id')
                );
            }
        });

        static::created(function (ParticipacionComision $participacionComision): void {
            $participacionComision->sincronizarFamiliasRelacionadas();
        });

        static::updated(function (ParticipacionComision $participacionComision): void {
            $participacionComision->sincronizarFamiliasRelacionadas();
        });

        static::deleted(function (ParticipacionComision $participacionComision): void {
            $participacionComision->familiaIdOriginal = $participacionComision->familiaIdDeIntegrante(
                $participacionComision->integrante_id
            );
            $participacionComision->sincronizarFamiliasRelacionadas();
        });
    }

    public function integrante(): BelongsTo
    {
        return $this->belongsTo(Integrante::class, 'integrante_id', 'id_integrante');
    }

    public function comision(): BelongsTo
    {
        return $this->belongsTo(Comision::class, 'comision_id', 'id_comision');
    }

    protected function sincronizarFamiliasRelacionadas(): void
    {
        $familiaIds = array_values(array_unique(array_filter([
            $this->familiaIdDeIntegrante($this->integrante_id),
            $this->familiaIdOriginal,
        ])));

        foreach ($familiaIds as $familiaId) {
            $familia = Familia::query()->find($familiaId);

            if ($familia !== null) {
                $familia->sincronizarParticipacionComision();
            }
        }

        $this->familiaIdOriginal = null;
    }

    protected function familiaIdDeIntegrante(?int $integranteId): ?int
    {
        if ($integranteId === null) {
            return null;
        }

        return Integrante::query()->whereKey($integranteId)->value('familia_id');
    }
}
