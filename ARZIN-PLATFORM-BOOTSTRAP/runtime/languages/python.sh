#!/usr/bin/env bash
set -euo pipefail
echo "Installing Python environment"

sudo apt update
sudo apt install -y python3 python3-pip python3-venv

python3 -m pip install --upgrade pip --break-system-packages

PACKAGES=(pytest requests pyyaml black ruff ansible ansible-core)
for pkg in "${PACKAGES[@]}"; do
    python3 -m pip install "$pkg" --break-system-packages
done

echo "[DONE] Python environment ready"
