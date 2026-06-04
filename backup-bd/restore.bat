@echo off
setlocal enabledelayedexpansion

for %%I in ("%~dp0..") do set "ROOT_DIR=%%~fI"
set "COMPOSE_FILE=%ROOT_DIR%\docker\docker-compose.yml"

set "SQL_FILE=%~1"
if "%SQL_FILE%"=="" (
  for /f "delims=" %%F in ('dir /b /o-d "%~dp0*.sql" 2^>nul') do (
    set "SQL_FILE=%~dp0%%F"
    goto :have_file
  )
)
:have_file
if "%SQL_FILE%"=="" (
  echo No SQL backup found.
  exit /b 1
)

type "%SQL_FILE%" | docker compose -f "%COMPOSE_FILE%" exec -T percona sh -lc "mysql -uroot -proot"

echo %SQL_FILE%
