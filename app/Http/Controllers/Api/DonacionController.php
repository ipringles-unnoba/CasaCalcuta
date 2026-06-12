<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Api\Concerns\CrudController;
use App\Http\Controllers\Api\Concerns\AuthenticatedRegistrar;
use App\Http\Controllers\Controller;
use App\Models\Donacion;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class DonacionController extends Controller
{
    use AuthenticatedRegistrar, CrudController;

    protected function modelClass(): string
    {
        return Donacion::class;
    }

    protected function relations(): array
    {
        return ['registradoPor', 'familia'];
    }

    protected function storeRules(): array
    {
        return [
            'origen' => ['required', 'string', 'max:255'],
            'descripcion' => ['required', 'string', 'max:255'],
            'cantidad' => ['required', 'integer', 'min:1'],
            'unidad_medida' => ['required', 'string', 'max:255'],
            'fecha_recepcion' => ['required', 'date'],
            'registrado_por' => ['sometimes', 'integer', 'exists:usuarios,id_usuario'],
            'familia_id' => ['nullable', 'integer', 'exists:familias,id_familia'],
        ];
    }

    protected function updateRules(Model $record): array
    {
        return [
            'origen' => ['sometimes', 'required', 'string', 'max:255'],
            'descripcion' => ['sometimes', 'required', 'string', 'max:255'],
            'cantidad' => ['sometimes', 'required', 'integer', 'min:1'],
            'unidad_medida' => ['sometimes', 'required', 'string', 'max:255'],
            'fecha_recepcion' => ['sometimes', 'required', 'date'],
            'registrado_por' => ['sometimes', 'integer', 'exists:usuarios,id_usuario'],
            'familia_id' => ['nullable', 'integer', 'exists:familias,id_familia'],
        ];
    }

    public function index(Request $request): JsonResponse
    {
        return $this->indexRecords($request);
    }

    public function store(Request $request): JsonResponse
    {
        $data = $request->validate($this->storeRules());
        $data = $this->applyAuthenticatedRegistrar($request, $data);

        if ($data instanceof JsonResponse) {
            return $data;
        }

        $record = Donacion::query()->create($data);

        return response()->json($record->load($this->relations()), 201);
    }

    public function show(Donacion $donacion): JsonResponse
    {
        return $this->showRecord($donacion);
    }

    public function update(Request $request, Donacion $donacion): JsonResponse
    {
        $data = $request->validate($this->updateRules($donacion));
        $data = $this->applyAuthenticatedRegistrar($request, $data);

        if ($data instanceof JsonResponse) {
            return $data;
        }

        $donacion->fill($data);
        $donacion->save();

        return response()->json($donacion->load($this->relations()));
    }

    public function destroy(Donacion $donacion): Response
    {
        return $this->destroyRecord($donacion);
    }
}
