#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$ARZIN_HOME/.." && pwd)"
cd "$ROOT/observability/docker"
docker compose down
echo "✅ ARZIN Observability stopped"
