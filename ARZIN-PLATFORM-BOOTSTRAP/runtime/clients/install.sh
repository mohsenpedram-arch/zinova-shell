#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "================================="
echo " ARZIN Database Client Installer"
echo "================================="
bash "$ROOT/postgres.sh"
bash "$ROOT/redis.sh"
bash "$ROOT/kafka.sh"
bash "$ROOT/sqlite.sh"
echo
echo "✅ ARZIN client tools installed"
