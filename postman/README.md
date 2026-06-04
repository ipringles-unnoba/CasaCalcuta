# CasaCalcuta API Postman

Colección inicial para probar el backend de `Usuario`.

## Contenido

- `CasaCalcuta.postman_collection.json`
- `CasaCalcuta.local.postman_environment.json`

## Orden de uso

1. Ejecutar `auth/login`.
2. Usar el token guardado en `access_token` como variable de colección y de entorno.
3. Probar los endpoints de `usuarios`.

## Base URL

- `http://localhost:8000`

## Endpoints incluidos

- `POST /api/auth/login`
- `GET /api/auth/me`
- `POST /api/auth/refresh`
- `POST /api/auth/logout`
- `GET /api/usuarios`
- `GET /api/usuarios/{usuario}`
- `POST /api/usuarios`
- `PUT /api/usuarios/{usuario}`
- `DELETE /api/usuarios/{usuario}`

## Campos de usuario

- `nombre`
- `apellido`
- `email`
- `contrasena`
- `contrasena_confirmation`
- `activo`
- `rol_id`
