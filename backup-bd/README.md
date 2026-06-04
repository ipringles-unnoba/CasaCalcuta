# Backup BD

Scripts para backup y restore de la base `casacalcuta`.

## Backup

- Linux/macOS: `./backup.sh`
- Windows: `backup.bat`

Genera un archivo `casacalcuta-full-YYYYmmdd-HHMMSS.sql` en esta carpeta.

## Restore

- Linux/macOS: `./restore.sh`
- Windows: `restore.bat`

Usa el `.sql` más reciente de la carpeta.

También podés pasar un archivo:

- Linux/macOS: `./restore.sh casacalcuta-full-YYYYmmdd-HHMMSS.sql`
- Windows: `restore.bat casacalcuta-full-YYYYmmdd-HHMMSS.sql`
