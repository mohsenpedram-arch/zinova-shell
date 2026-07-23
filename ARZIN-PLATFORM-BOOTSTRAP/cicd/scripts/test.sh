#!/usr/bin/env bash
set -euo pipefail

SERVICE=${1:-}
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$ROOT/services/$SERVICE"
./gradlew test
echo "[OK] Tests passed"
