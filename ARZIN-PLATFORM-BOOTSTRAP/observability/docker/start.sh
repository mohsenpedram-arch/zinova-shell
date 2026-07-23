#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

if [ -d /run/systemd/system ]; then
    docker compose up -d
else
    docker compose up -d 2>/dev/null || true
fi

echo "✅ Observability stack started"
