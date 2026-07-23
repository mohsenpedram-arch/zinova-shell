#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

# بررسی وجود systemd
if [ -d /run/systemd/system ]; then
    echo "[INFO] Starting with docker-compose (systemd)"
    docker compose up -d
else
    echo "[INFO] No systemd detected, running in background"
    docker compose up -d || true
fi

echo "✅ ARZIN infrastructure started"
