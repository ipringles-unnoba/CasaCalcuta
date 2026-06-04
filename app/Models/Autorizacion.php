<?php

namespace App\Models;

use Database\Factories\AutorizacionFactory;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

#[Fillable(['tipo', 'vigente', 'vencimiento'])]
class Autorizacion extends Model
{
    /** @use HasFactory<AutorizacionFactory> */
    use HasFactory;

    protected $fillable = ['tipo', 'vigente', 'vencimiento'];

    protected $table = 'autorizaciones';

    protected $primaryKey = 'id_autorizacion';

    protected function casts(): array
    {
        return [
            'vigente' => 'boolean',
            'vencimiento' => 'date',
        ];
    }
}
