#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export ARZIN_HOME="$ROOT/arzin-cli"
source "$ARZIN_HOME/core/config.sh"

echo "================================================="
echo " Package Resolver"
echo "================================================="

# ==================================================
# تابع بررسی نصب بودن بسته
# ==================================================

is_installed() {
    local pkg=$1
    dpkg -s "$pkg" 2>/dev/null | grep -q "Status: install ok installed"
}

# ==================================================
# خواندن بسته‌ها از مانیفست
# ==================================================

BASE_PACKAGES_RAW=$(yq '.toolchain.base_packages[]' "$MANIFEST_FILE")
mapfile -t PKG_ARRAY <<< "$BASE_PACKAGES_RAW"

# ==================================================
# نصب تک‌تک با بررسی
# ==================================================

echo "[1] Installing base packages..."
for pkg in "${PKG_ARRAY[@]}"; do
    pkg_clean=$(echo "$pkg" | tr -d '"' | xargs)
    [ -z "$pkg_clean" ] && continue

    if is_installed "$pkg_clean"; then
        echo "[OK] $pkg_clean already installed"
    else
        echo "[INSTALL] $pkg_clean"
        sudo apt install -y "$pkg_clean" || echo "[WARN] Failed to install $pkg_clean"
    fi
done

# ==================================================
# Java
# ==================================================

echo
echo "[2] Java..."
JAVA_VERSION=$(yq '.toolchain.languages.java.version' "$MANIFEST_FILE")
JAVA_PKG="openjdk-${JAVA_VERSION}-jdk"

if is_installed "$JAVA_PKG"; then
    echo "[OK] Java $JAVA_VERSION already installed"
else
    echo "[INSTALL] Java $JAVA_VERSION"
    sudo apt install -y "$JAVA_PKG"
fi

# ==================================================
# Python
# ==================================================

echo
echo "[3] Python..."
if command -v python3 >/dev/null 2>&1; then
    echo "[OK] Python already installed: $(python3 --version)"
else
    echo "[INSTALL] Python"
    sudo apt install -y python3 python3-pip python3-venv
fi

# ==================================================
# Rust
# ==================================================

echo
echo "[4] Rust..."
if command -v rustc >/dev/null 2>&1; then
    echo "[OK] Rust already installed: $(rustc --version)"
else
    echo "[INSTALL] Rust"
    curl -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

# ==================================================
# Kubernetes (profile-based)
# ==================================================

PROFILE=${1:-developer}
if [[ "$PROFILE" != "developer" ]]; then
    echo
    echo "[5] Kubernetes tools..."
    bash "$ROOT/runtime/kubernetes/install.sh" "$PROFILE"
fi

echo "================================================="
echo " Package resolution completed"
echo "================================================="
