#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Docker Validation"
echo "================================="

FAILED=0

check() {
    CMD=$1
    if command -v "$CMD" >/dev/null 2>&1; then
        echo "[OK] $CMD"
    else
        echo "[FAIL] $CMD missing"
        FAILED=1
    fi
}

check docker

echo
echo "Docker Version"
docker --version

echo
echo "Compose Version"
docker compose version

echo
echo "Containerd"
if command -v containerd >/dev/null 2>&1; then
    containerd --version
else
    echo "[FAIL] containerd not found in PATH"
    FAILED=1
fi

echo
echo "Docker Test Container"
if docker run --rm hello-world >/dev/null 2>&1; then
    echo "[OK] Docker runtime execution"
else
    echo "[FAIL] Docker execution"
    FAILED=1
fi

exit $FAILED
