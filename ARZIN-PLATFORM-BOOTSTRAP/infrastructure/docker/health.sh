#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Infrastructure Health"
echo "================================="
FAILED=0
check() {
  if docker ps --filter "name=$1" --filter "status=running" --format "{{.Names}}" | grep -q "$1"; then
    echo "[OK] $1"
  else
    echo "[FAIL] $1"
    FAILED=1
  fi
}
check arzin-postgres
check arzin-redis
check arzin-kafka
check arzin-keycloak
check arzin-vault
exit $FAILED
