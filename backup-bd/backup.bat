@echo off
setlocal enabledelayedexpansion

for %%I in ("%~dp0..") do set "ROOT_DIR=%%~fI"
set "COMPOSE_FILE=%ROOT_DIR%\docker\docker-compose.yml"

for /f %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set "TS=%%T"
set "OUT_FILE=%~dp0casacalcuta-full-%TS%.sql"

docker compose -f "%COMPOSE_FILE%" exec -T percona sh -lc "mysqldump -uroot -proot --databases casacalcuta --routines --triggers --events --single-transaction --add-drop-database --add-drop-table" > "%OUT_FILE%"

echo %OUT_FILE%
