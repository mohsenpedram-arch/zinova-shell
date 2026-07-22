#!/usr/bin/env bash
set -euo pipefail
echo "Installing SQLite"

if command -v sqlite3 >/dev/null 2>&1; then
    VERSION=$(sqlite3 --version | grep -oP '^\d+\.\d+' | head -1)
    if [[ "$VERSION" == "3."* ]]; then
        echo "[OK] SQLite 3.x already installed"
        exit 0
    else
        echo "[WARN] SQLite found but version $VERSION != 3.x"
    fi
fi

sudo apt update
sudo apt install -y sqlite3
echo "[DONE] SQLite installed"
sqlite3 --version
