#!/usr/bin/env bash
set -euo pipefail
echo "Installing Helm"

if command -v helm >/dev/null 2>&1; then
    echo "[OK] Helm exists"
    exit 0
fi

curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version
echo "[DONE] Helm installed"
