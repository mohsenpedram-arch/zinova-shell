#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Runtime Status"
echo "================================="
docker ps --filter "name=arzin" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
