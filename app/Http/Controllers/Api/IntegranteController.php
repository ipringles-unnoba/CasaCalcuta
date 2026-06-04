<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Integrante;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;

class IntegranteController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return Integrante::class;
    }

    protected function relations(): array
    {
        return ['familia'];
    }

    protected function storeRules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255'],
            'apellido' => ['required', 'string', 'max:255'],
            'fecha_nacimiento' => ['required', 'date'],
            'tipo_documento' => ['required', 'string', 'max:255'],
            'numero_documento' => ['required', 'string', 'max:255'],
            'categoria_etaria' => ['required', 'string', 'max:255'],
            'referente' => ['required', 'boolean'],
            'familia_id' => ['required', 'integer', 'exists:familias,id_familia'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'nombre' => ['sometimes', 'required', 'string', 'max:255'],
            'apellido' => ['sometimes', 'required', 'string', 'max:255'],
            'fecha_nacimiento' => ['sometimes', 'required', 'date'],
            'tipo_documento' => ['sometimes', 'required', 'string', 'max:255'],
            'numero_documento' => ['sometimes', 'required', 'string', 'max:255'],
            'categoria_etaria' => ['sometimes', 'required', 'string', 'max:255'],
            'referente' => ['sometimes', 'required', 'boolean'],
            'familia_id' => ['sometimes', 'required', 'integer', 'exists:familias,id_familia'],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        return $this->storeRecord($request);
    }

    public function show(Integrante $integrante): JsonResponse
    {
        return $this->showRecord($integrante);
    }

    public function update(Request $request, Integrante $integrante): JsonResponse
    {
        return $this->updateRecord($request, $integrante);
    }

    public function destroy(Integrante $integrante): Response
    {
        return $this->destroyRecord($integrante);
    }

    public function documentos(Integrante $integrante): JsonResponse
    {
        return response()->json($integrante->documentos()->latest('id_documento')->get());
    }

    public function participacionesComision(Integrante $integrante): JsonResponse
    {
        return response()->json($integrante->participacionesComision()->latest('id_participacion_comision')->get());
    }
}
