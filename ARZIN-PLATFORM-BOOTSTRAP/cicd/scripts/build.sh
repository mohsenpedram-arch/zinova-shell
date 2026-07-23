#!/usr/bin/env bash
set -euo pipefail

SERVICE=${1:-}
if [ -z "$SERVICE" ]; then
    echo "Usage: build.sh <service>"
    exit 1
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SERVICE_DIR="$ROOT/services/$SERVICE"

if [ ! -d "$SERVICE_DIR" ]; then
    echo "[ERROR] Service not found: $SERVICE"
    exit 1
fi

echo "================================="
echo " ARZIN BUILD"
echo " SERVICE: $SERVICE"
echo "================================="

cd "$SERVICE_DIR"
./gradlew clean build

echo "[OK] Build completed"
