#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Observability Status"
echo "================================="
docker ps --filter "name=arzin-" --filter "name=prometheus|grafana|loki|tempo|otel" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
