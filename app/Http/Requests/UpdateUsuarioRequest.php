<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateUsuarioRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        $usuario = $this->route('usuario');

        return [
            'nombre' => ['sometimes', 'required', 'string', 'max:255'],
            'apellido' => ['sometimes', 'required', 'string', 'max:255'],
            'email' => [
                'sometimes',
                'required',
                'string',
                'lowercase',
                'email',
                'max:255',
                Rule::unique('usuarios', 'email')->ignore($usuario?->getKey(), $usuario?->getKeyName()),
            ],
            'contrasena' => ['sometimes', 'nullable', 'string', 'min:8', 'confirmed'],
            'activo' => ['sometimes', 'boolean'],
            'rol_id' => ['sometimes', 'required', 'integer', 'exists:roles,id_rol'],
        ];
    }

    public function messages(): array
    {
        return [
            'contrasena.min' => 'La contraseña debe tener al menos :min caracteres.',
            'contrasena.confirmed' => 'La confirmación de la contraseña no coincide.',
        ];
    }
}
