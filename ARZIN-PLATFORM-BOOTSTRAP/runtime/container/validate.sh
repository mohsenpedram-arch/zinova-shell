#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Container Runtime Check"
echo "================================="

docker info > /tmp/arzin-docker-info

echo "[INFO] Docker Root"
grep "Docker Root Dir" /tmp/arzin-docker-info || echo "[WARN] Not found"

echo
echo "[INFO] Storage Driver"
grep "Storage Driver" /tmp/arzin-docker-info || echo "[WARN] Not found"

echo
echo "[INFO] Runtime Ready"

rm -f /tmp/arzin-docker-info
