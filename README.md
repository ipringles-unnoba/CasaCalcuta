# CasaCalcuta API

CasaCalcuta es una API backend en Laravel para gestionar usuarios, roles, permisos y notificaciones.

Usa autenticación JWT y expone endpoints REST en `routes/api.php`.

## Que hace

- Autenticación con JWT.
- CRUD de usuarios.
- Manejo de roles y permisos.
- Respuestas JSON para consumo desde cliente externo o Postman.
- Base de datos MySQL/Percona con migraciones y seeders.

## Carpetas clave

### `postman/`

Colección y entorno para probar la API.

- `CasaCalcuta.postman_collection.json`: endpoints listos para usar.
- `CasaCalcuta.local.postman_environment.json`: variables como `base_url` y `access_token`.
- `README.md`: instrucciones de uso.

### `docker/`

Configuración del stack de desarrollo.

- `docker-compose.yml`: levanta `CasaCalcuta-backend` y `CasaCalcuta-BD`.
- El backend expone Laravel en `http://localhost:8000`.
- La base expone `3306` para acceso directo si hace falta.

### `backup-bd/`

Backups de la base de datos y scripts de restauración.

- `casacalcuta-full-YYYYmmdd-HHMMSS.sql`: dump completo con estructura y datos.
- `backup.sh` / `backup.bat`: generan un nuevo backup.
- `restore.sh` / `restore.bat`: restauran el dump más reciente o uno indicado por parámetro.

## Arranque

```bash
docker compose -f docker/docker-compose.yml up -d
```

## Seed inicial

```bash
docker compose -f docker/docker-compose.yml exec -T app php artisan db:seed --force
```

## AGENTES

Usar este prompt para transferir contexto base a un agente:

```text
Proyecto: CasaCalcuta

Contexto:
- Es una API backend en Laravel.
- No tiene frontend React/Inertia/Vite.
- Usa JWT para autenticación.
- La base de datos es MySQL/Percona.
- El stack Docker vive en `CasaCalcuta/docker/docker-compose.yml`.
- Los contenedores se llaman `CasaCalcuta-backend` y `CasaCalcuta-BD`.
- El backend escucha en `localhost:8000`.
- La BD expone `3306`.

Carpetas importantes:
- `postman/`: colección y entorno para probar endpoints.
- `docker/`: definición del stack.
- `backup-bd/`: dumps y scripts de backup/restore.

Objetivo del agente:
- [describir tarea concreta]

Restricciones:
- No agregar frontend.
- Mantener la API en Laravel.
- Usar Docker Compose desde `CasaCalcuta/docker`.
- No ejecutar comandos PHP/Composer/Artisan/NPM ni tests directamente en el host.

Verificación esperada:
- [indicar comandos o pruebas necesarias]
```
