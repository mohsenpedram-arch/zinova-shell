#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$ARZIN_HOME/.." && pwd)"
cd "$ROOT/observability/docker"
docker compose up -d
echo "✅ ARZIN Observability started"
echo "  Prometheus: http://localhost:9090"
echo "  Grafana: http://localhost:3000 (admin/arzin)"
echo "  Loki: http://localhost:3100"
echo "  Tempo: http://localhost:3200"
