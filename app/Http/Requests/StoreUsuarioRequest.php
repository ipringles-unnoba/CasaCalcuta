<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreUsuarioRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nombre' => ['required', 'string', 'max:255'],
            'apellido' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'lowercase', 'email', 'max:255', 'unique:usuarios,email'],
            'contrasena' => ['required', 'string', 'min:8', 'confirmed'],
            'activo' => ['sometimes', 'boolean'],
            'rol_id' => ['required', 'integer', 'exists:roles,id_rol'],
        ];
    }

    public function messages(): array
    {
        return [
            'contrasena.required' => 'La contraseña es obligatoria.',
            'contrasena.min' => 'La contraseña debe tener al menos :min caracteres.',
            'contrasena.confirmed' => 'La confirmación de la contraseña no coincide.',
        ];
    }
}
