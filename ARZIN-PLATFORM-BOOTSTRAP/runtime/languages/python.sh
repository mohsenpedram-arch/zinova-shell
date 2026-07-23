#!/usr/bin/env bash
set -euo pipefail

echo "================================================="
echo " Python Environment"
echo "================================================="

# ==================================================
# Python
# ==================================================

if command -v python3 >/dev/null 2>&1; then
    echo "[OK] Python already installed: $(python3 --version)"
else
    echo "[INSTALL] Python"
    sudo apt update
    sudo apt install -y python3 python3-pip python3-venv
fi

# ==================================================
# pip
# ==================================================

if python3 -m pip --version >/dev/null 2>&1; then
    echo "[OK] pip already installed"
else
    echo "[INSTALL] pip"
    sudo apt install -y python3-pip
fi

# ==================================================
# پکیج‌ها (فقط در صورت عدم وجود)
# ==================================================

PACKAGES=(pytest requests pyyaml black ruff ansible ansible-core)

for pkg in "${PACKAGES[@]}"; do
    if python3 -c "import $pkg" 2>/dev/null; then
        echo "[OK] $pkg already installed"
    else
        echo "[INSTALL] $pkg"
        python3 -m pip install "$pkg" --break-system-packages 2>/dev/null || \
        python3 -m pip install "$pkg" --user 2>/dev/null || \
        echo "[WARN] Could not install $pkg"
    fi
done

echo "================================================="
echo " Python environment ready"
echo "================================================="
