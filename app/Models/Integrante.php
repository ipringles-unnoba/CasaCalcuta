<?php

namespace App\Models;

use Database\Factories\IntegranteFactory;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

#[Fillable(['nombre', 'apellido', 'fecha_nacimiento', 'tipo_documento', 'numero_documento', 'referente', 'familia_id'])]
class Integrante extends Model
{
    /** @use HasFactory<IntegranteFactory> */
    use HasFactory;

    protected $fillable = ['nombre', 'apellido', 'fecha_nacimiento', 'tipo_documento', 'numero_documento', 'referente', 'familia_id'];

    protected $appends = ['categoria_etaria'];

    protected ?int $familiaIdOriginal = null;

    protected $table = 'integrantes';

    protected $primaryKey = 'id_integrante';

    protected function casts(): array
    {
        return [
            'fecha_nacimiento' => 'date',
            'referente' => 'boolean',
        ];
    }

    protected function categoriaEtaria(): Attribute
    {
        return Attribute::make(
            get: function (): ?string {
                if ($this->fecha_nacimiento === null) {
                    return null;
                }

                return $this->fecha_nacimiento->age < 18 ? 'MENOR' : 'ADULTO';
            },
        );
    }

    protected static function booted(): void
    {
        static::creating(function (Integrante $integrante): void {
            $integrante->familiaIdOriginal = $integrante->familia_id;
        });

        static::updating(function (Integrante $integrante): void {
            if ($integrante->isDirty('familia_id')) {
                $integrante->familiaIdOriginal = $integrante->getOriginal('familia_id');
            }
        });

        static::created(function (Integrante $integrante): void {
            $integrante->recalcularFamiliasRelacionadas();
        });

        static::updated(function (Integrante $integrante): void {
            if (! $integrante->wasChanged(['fecha_nacimiento', 'familia_id'])) {
                return;
            }

            $integrante->recalcularFamiliasRelacionadas();
        });

        static::deleted(function (Integrante $integrante): void {
            $integrante->recalcularFamiliasRelacionadas();
        });
    }

    protected function recalcularFamiliasRelacionadas(): void
    {
        $familiaIds = array_values(array_unique(array_filter([
            $this->familiaIdOriginal,
            $this->familia_id,
        ])));

        foreach ($familiaIds as $familiaId) {
            $familia = Familia::query()->find($familiaId);

            if ($familia !== null) {
                $familia->recalcular_puntaje_menores();
            }
        }

        $this->familiaIdOriginal = null;
    }

    public function scopeProximosCumpleanos($query, int $dias = 7)
    {
        $startMD = now()->format('m-d');
        $endMD = now()->addDays($dias)->format('m-d');

        if ($startMD <= $endMD) {
            $query->whereRaw("DATE_FORMAT(fecha_nacimiento, '%m-%d') BETWEEN ? AND ?", [$startMD, $endMD]);
        } else {
            $query->where(function ($q) use ($startMD, $endMD): void {
                $q->whereRaw("DATE_FORMAT(fecha_nacimiento, '%m-%d') >= ?", [$startMD])
                  ->orWhereRaw("DATE_FORMAT(fecha_nacimiento, '%m-%d') <= ?", [$endMD]);
            });
        }

        return $query;
    }

    public function scopeCumpleanosDelMes($query, ?int $mes = null)
    {
        $mes = $mes ?? now()->month;

        return $query->whereRaw('MONTH(fecha_nacimiento) = ?', [$mes]);
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
