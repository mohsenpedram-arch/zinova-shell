#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$ARZIN_HOME/.." && pwd)"
cd "$ROOT/infrastructure/docker"
docker compose restart
echo "✅ ARZIN infrastructure restarted"
