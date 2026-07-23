#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export ARZIN_HOME="$ROOT/arzin-cli"
source "$ARZIN_HOME/core/config.sh"

echo "================================================="
echo " VERSION VALIDATION"
echo "================================================="

FAILED=0

check_version() {
    local NAME=$1
    local CURRENT_RAW=$2
    local REQUIRED_RAW=$3

    # حذف نقل قول و فاصله‌های اضافی
    local CURRENT=$(echo "$CURRENT_RAW" | tr -d '"' | xargs)
    local REQUIRED=$(echo "$REQUIRED_RAW" | tr -d '"' | xargs)

    # استخراج عدد اصلی (مثل 21 از 21.0.11 یا 26 از 26.0.0)
    local CURRENT_MAJOR=$(echo "$CURRENT" | grep -oP '^\d+' | head -1)
    local REQUIRED_MAJOR=$(echo "$REQUIRED" | grep -oP '^\d+' | head -1)

    if [[ "$CURRENT_MAJOR" == "$REQUIRED_MAJOR" ]]; then
        echo "[OK] $NAME: $CURRENT (matches $REQUIRED)"
    else
        echo "[FAIL] $NAME: expected $REQUIRED, got $CURRENT"
        FAILED=1
    fi
}

# Java
JAVA_REQUIRED=$(yq '.toolchain.languages.java.version' "$MANIFEST_FILE")
JAVA_RAW=$(java -version 2>&1 | head -1 | grep -oP 'version "\K[^"]+' || echo "unknown")
check_version "Java" "$JAVA_RAW" "$JAVA_REQUIRED"

# Python
PYTHON_REQUIRED=$(yq '.toolchain.languages.python.version' "$MANIFEST_FILE")
PYTHON_RAW=$(python3 --version 2>&1 | grep -oP '\d+\.\d+' | head -1)
check_version "Python" "$PYTHON_RAW" "$PYTHON_REQUIRED"

# Docker: فقط عدد اصلی از مانفیست خوانده می‌شود
DOCKER_REQUIRED_RAW=$(yq '.toolchain.container.docker.version' "$MANIFEST_FILE")
DOCKER_REQUIRED_MAJOR=$(echo "$DOCKER_REQUIRED_RAW" | grep -oP '^\d+' | head -1)
DOCKER_RAW=$(docker --version 2>&1 | grep -oP '\d+\.\d+' | head -1)
check_version "Docker" "$DOCKER_RAW" "$DOCKER_REQUIRED_MAJOR"

echo "================================================="
if [ $FAILED -eq 0 ]; then
    echo " All versions match requirements"
else
    echo " Some versions do not match requirements"
fi
echo "================================================="
exit $FAILED
