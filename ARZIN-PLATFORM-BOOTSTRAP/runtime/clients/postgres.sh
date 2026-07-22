#!/usr/bin/env bash
set -euo pipefail
echo "Installing PostgreSQL Client 16"

if command -v psql >/dev/null 2>&1; then
    VERSION=$(psql --version | grep -oP '(?<=psql \(PostgreSQL\) )\d+\.\d+' || echo "unknown")
    if [[ "$VERSION" == "16."* ]]; then
        echo "[OK] PostgreSQL client 16 already installed"
        exit 0
    else
        echo "[WARN] PostgreSQL client found but version $VERSION != 16.x"
    fi
fi

sudo apt update
sudo apt install -y postgresql-client || sudo apt install -y postgresql-client-16
echo "[DONE] PostgreSQL client installed"
psql --version
