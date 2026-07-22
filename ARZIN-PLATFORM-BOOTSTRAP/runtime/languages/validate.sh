#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Language Runtime Check"
echo "================================="

FAILED=0

check() {
    NAME=$1
    CMD=$2
    if command -v "$CMD" >/dev/null 2>&1; then
        echo "[OK] $NAME"
    else
        echo "[FAIL] $NAME"
        FAILED=1
    fi
}

check "Java" java
check "Gradle" gradle
check "Kotlin" kotlinc
check "Python" python3
check "Rust" rustc
check "Cargo" cargo

echo
java -version 2>&1 | head -1 || true
gradle --version 2>&1 | head -5 || true
kotlinc -version 2>&1 || true
python3 --version
rustc --version

exit $FAILED
