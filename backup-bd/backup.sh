#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
COMPOSE_DIR="$ROOT_DIR/docker"
TS="$(date +%Y%m%d-%H%M%S)"
OUT_FILE="$SCRIPT_DIR/casacalcuta-full-$TS.sql"

docker compose -f "$COMPOSE_DIR/docker-compose.yml" exec -T percona sh -lc 'mysqldump -uroot -proot --databases casacalcuta --routines --triggers --events --single-transaction --add-drop-database --add-drop-table' > "$OUT_FILE"

echo "$OUT_FILE"
