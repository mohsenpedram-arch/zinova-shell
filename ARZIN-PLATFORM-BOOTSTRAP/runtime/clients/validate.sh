#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Client Validation"
echo "================================="

FAILED=0

check_version() {
    NAME=$1
    CMD=$2
    VERSION_PATTERN=$3
    if command -v "$CMD" >/dev/null 2>&1; then
        VERSION=$($CMD --version 2>&1 | grep -oP "$VERSION_PATTERN" | head -1)
        if [[ -n "$VERSION" ]]; then
            echo "[OK] $NAME ($VERSION)"
        else
            echo "[WARN] $NAME installed but version pattern not matched"
        fi
    else
        echo "[FAIL] $NAME not found"
        FAILED=1
    fi
}

check_version "PostgreSQL Client" "psql" '\d+\.\d+'
check_version "Redis CLI" "redis-cli" '\d+\.\d+'
check_version "Kafka Client" "kcat" '\d+\.\d+\.\d+'
check_version "SQLite" "sqlite3" '\d+\.\d+'

echo
echo "Detailed versions:"
psql --version 2>&1 | head -1 || true
redis-cli --version 2>&1 | head -1 || true
kcat -V 2>&1 | head -1 || true
sqlite3 --version 2>&1 | head -1 || true

exit $FAILED
