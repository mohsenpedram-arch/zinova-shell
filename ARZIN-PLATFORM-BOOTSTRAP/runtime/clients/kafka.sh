#!/usr/bin/env bash
set -euo pipefail
echo "Installing Kafka CLI Client (kcat)"

if command -v kcat >/dev/null 2>&1; then
    VERSION=$(kcat -V 2>&1 | grep -oP '\d+\.\d+\.\d+' | head -1)
    if [[ "$VERSION" == "1.7.1" ]]; then
        echo "[OK] kcat 1.7.1 already installed"
        exit 0
    else
        echo "[WARN] kcat found but version $VERSION != 1.7.1"
    fi
fi

# تلاش برای نصب با apt
if sudo apt install -y kcat 2>/dev/null; then
    echo "[OK] kcat installed from default repo"
else
    echo "[INFO] kcat not in default repo, trying backports or building from source..."
    # برای دبیان: فعال کردن backports
    if grep -q "Debian" /etc/os-release; then
        sudo apt install -y software-properties-common
        sudo add-apt-repository -y "deb http://deb.debian.org/debian bookworm-backports main"
        sudo apt update
        sudo apt install -y kcat
    else
        # برای اوبونتو: از مخزن universe
        sudo add-apt-repository -y universe
        sudo apt update
        sudo apt install -y kcat
    fi
fi

if command -v kcat >/dev/null 2>&1; then
    echo "[DONE] Kafka client installed"
    kcat -V
else
    echo "[FAIL] Could not install kcat"
    exit 1
fi
