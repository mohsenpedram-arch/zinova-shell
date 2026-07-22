#!/usr/bin/env bash
set -euo pipefail
PROFILE=${1:-developer}
echo "================================="
echo " ARZIN Kubernetes Validation"
echo " PROFILE: $PROFILE"
echo "================================="

if [[ "$PROFILE" == "developer" ]]; then
    echo "[OK] Kubernetes tools disabled (profile: developer)"
    exit 0
fi

FAILED=0
for CMD in kubectl helm k9s; do
    if command -v "$CMD" >/dev/null 2>&1; then
        echo "[OK] $CMD"
    else
        echo "[FAIL] $CMD missing"
        FAILED=1
    fi
done

exit $FAILED
