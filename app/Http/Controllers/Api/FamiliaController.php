<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Controller;
use App\Models\Integrante;
use App\Models\Familia;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class FamiliaController extends Controller
{
    use CrudController;

    protected function modelClass(): string
    {
        return Familia::class;
    }

    protected function relations(): array
    {
        return ['registradoPor', 'referente'];
    }

    protected function storeRules(): array
    {
        return [
            'direccion' => ['required', 'string', 'max:255'],
            'telefono' => ['required', 'string', 'max:50'],
            'puntaje_prioridad' => ['required', 'integer', 'min:0'],
            'prioridad_social' => ['required', 'string', 'max:255'],
            'estado_lista' => ['required', 'string', 'max:255'],
            'fecha_ingreso' => ['required', 'date'],
            'activa' => ['required', 'boolean'],
            'registrado_por' => ['required', 'integer', 'exists:usuarios,id_usuario'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'direccion' => ['sometimes', 'required', 'string', 'max:255'],
            'telefono' => ['sometimes', 'required', 'string', 'max:50'],
            'puntaje_prioridad' => ['sometimes', 'required', 'integer', 'min:0'],
            'prioridad_social' => ['sometimes', 'required', 'string', 'max:255'],
            'estado_lista' => ['sometimes', 'required', 'string', 'max:255'],
            'fecha_ingreso' => ['sometimes', 'required', 'date'],
            'activa' => ['sometimes', 'required', 'boolean'],
            'registrado_por' => ['sometimes', 'required', 'integer', 'exists:usuarios,id_usuario'],
            'referente_id' => [
                'sometimes',
                'nullable',
                'integer',
                Rule::exists('integrantes', 'id_integrante')->where('familia_id', $record->getKey()),
            ],
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

    public function show(Familia $familia): JsonResponse
    {
        return $this->showRecord($familia);
    }

    public function update(Request $request, Familia $familia): JsonResponse
    {
        return $this->updateRecord($request, $familia);
    }

    public function destroy(Familia $familia): Response
    {
        return $this->destroyRecord($familia);
    }

    public function integrantes(Familia $familia): JsonResponse
    {
        return response()->json($familia->integrantes()->latest('id_integrante')->get());
    }

    public function donaciones(Familia $familia): JsonResponse
    {
        return response()->json($familia->donaciones()->latest('id_donacion')->get());
    }

    public function pedidosEspeciales(Familia $familia): JsonResponse
    {
        return response()->json($familia->pedidosEspeciales()->latest('id_pedido_especial')->get());
    }

    public function visitasDomiciliarias(Familia $familia): JsonResponse
    {
        return response()->json($familia->visitasDomiciliarias()->latest('id_visita_domiciliaria')->get());
    }

    public function registrosAsistencia(Familia $familia): JsonResponse
    {
        return response()->json($familia->registrosAsistencia()->latest('id_registro_asistencia')->get());
    }

    public function referente(Familia $familia): JsonResponse
    {
        return response()->json($familia->load('referente')->referente);
    }

    public function syncReferente(Request $request, Familia $familia): JsonResponse
    {
        $data = $request->validate([
            'integrante_id' => [
                'required',
                'integer',
                Rule::exists('integrantes', 'id_integrante')->where('familia_id', $familia->id_familia),
            ],
        ]);

        $integrante = $familia->integrantes()->whereKey($data['integrante_id'])->firstOrFail();

        DB::transaction(function () use ($familia, $integrante): void {
            $familia->loadMissing('referente');

            if ($familia->referente && $familia->referente->getKey() !== $integrante->getKey()) {
                $familia->referente->forceFill(['referente' => false])->save();
            }

            $integrante->forceFill(['referente' => true])->save();
            $familia->forceFill(['referente_id' => $integrante->getKey()])->save();
        });

        return response()->json($familia->fresh(['registradoPor', 'referente']));
    }

    public function clearReferente(Familia $familia): JsonResponse
    {
        DB::transaction(function () use ($familia): void {
            $familia->loadMissing('referente');

            if ($familia->referente) {
                $familia->referente->forceFill(['referente' => false])->save();
            }

            $familia->forceFill(['referente_id' => null])->save();
        });

        return response()->json($familia->fresh(['registradoPor', 'referente']));
    }
}
