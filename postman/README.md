# CasaCalcuta API Postman

Colección para probar la API backend de CasaCalcuta.

## Archivos

- `CasaCalcuta.postman_collection.json`
- `CasaCalcuta.local.postman_environment.json`
- `CasaCalcuta.deploy.postman_environment.json`

## Uso

1. Importar colección y entorno.
2. Ejecutar `auth/login`.
3. Reutilizar `{{access_token}}` en los endpoints protegidos.
4. Crear primero entidades base y luego relaciones.

## Base URL local

- `http://localhost:8000`

## Endpoints

- `POST /api/auth/login`
- `GET /api/auth/me`
- `POST /api/auth/refresh`
- `POST /api/auth/logout`
- `GET|POST|PUT|DELETE /api/usuarios`
- `GET|POST|PUT|DELETE /api/roles`
- `GET|POST|PUT|DELETE /api/permisos`
- `GET|POST|PUT|DELETE /api/notificaciones`
- `GET|POST|PUT|DELETE /api/familias`
- `GET|POST|PUT|DELETE /api/integrantes`
- `GET|POST|PUT|DELETE /api/donaciones`
- `GET|POST|PUT|DELETE /api/pedidos-especiales`
- `GET|POST|PUT|DELETE /api/comisiones`
- `GET|POST|PUT|DELETE /api/participaciones-comision`
- `GET|POST|PUT|DELETE /api/visitas-domiciliarias`
- `GET|POST|PUT|DELETE /api/autorizaciones`
- `GET /api/auditorias`
- `GET /api/auditorias/{auditoria}`
- `GET|POST|PUT|DELETE /api/registros-asistencia`
- `GET|POST|PUT|DELETE /api/documentos`

## Endpoints de relación

- `GET /api/usuarios/{usuario}/notificaciones`
- `POST /api/usuarios/{usuario}/notificaciones/sync`
- `GET /api/roles/{rol}/permisos`
- `POST /api/roles/{rol}/permisos/sync`
- `GET /api/familias/{familia}/integrantes`
- `GET /api/familias/{familia}/donaciones`
- `GET /api/familias/{familia}/pedidos-especiales`
- `GET /api/familias/{familia}/registros-asistencia`
- `GET /api/familias/{familia}/visitas-domiciliarias`
- `GET /api/integrantes/{integrante}/documentos`
- `GET /api/integrantes/{integrante}/participaciones-comision`
- `GET /api/comisiones/{comision}/participaciones`
- `GET /api/visitas-domiciliarias/{visitaDomiciliaria}/usuarios`
- `POST /api/visitas-domiciliarias/{visitaDomiciliaria}/usuarios/sync`
- `GET /api/documentos/{documento}/integrantes`
- `POST /api/documentos/{documento}/integrantes/sync`

## Verificacion local

- Login con `admin@example.com / password`
- `GET /api/auth/me`
- `GET /api/roles`
- `POST /api/familias`
- `POST /api/integrantes`
- `POST /api/comisiones`
- `POST /api/participaciones-comision`
- `POST /api/documentos`
