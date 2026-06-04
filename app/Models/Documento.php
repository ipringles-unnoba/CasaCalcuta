<?php

namespace App\Models;

use Database\Factories\DocumentoFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

#[Fillable(['tipo', 'vigente', 'vencimiento'])]
class Documento extends Model
{
    /** @use HasFactory<DocumentoFactory> */
    use HasFactory;

    protected $fillable = ['tipo', 'vigente', 'vencimiento'];

    protected $table = 'documentos';

    protected $primaryKey = 'id_documento';

    protected function casts(): array
    {
        return [
            'vigente' => 'boolean',
            'vencimiento' => 'date',
        ];
    }

    public function integrantes(): BelongsToMany
    {
        return $this->belongsToMany(Integrante::class, 'documentacion_integrante', 'documento_id', 'integrante_id');
    }
}
