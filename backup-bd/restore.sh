#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
COMPOSE_DIR="$ROOT_DIR/docker"
SQL_FILE="${1:-$(ls -1t "$SCRIPT_DIR"/*.sql | head -n 1)}"

docker compose -f "$COMPOSE_DIR/docker-compose.yml" exec -T percona sh -lc 'mysql -uroot -proot' < "$SQL_FILE"

echo "$SQL_FILE"
