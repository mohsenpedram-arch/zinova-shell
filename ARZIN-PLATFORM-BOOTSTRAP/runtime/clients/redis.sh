#!/usr/bin/env bash
set -euo pipefail
echo "Installing Redis CLI"

if command -v redis-cli >/dev/null 2>&1; then
    VERSION=$(redis-cli --version | grep -oP '\d+\.\d+' | head -1)
    if [[ "$VERSION" == "7."* ]]; then
        echo "[OK] Redis CLI 7.x already installed"
        exit 0
    else
        echo "[WARN] Redis CLI found but version $VERSION != 7.x"
    fi
fi

sudo apt update
sudo apt install -y redis-tools
echo "[DONE] Redis CLI installed"
redis-cli --version
