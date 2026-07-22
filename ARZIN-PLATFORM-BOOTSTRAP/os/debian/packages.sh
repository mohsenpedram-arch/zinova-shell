#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Debian Base Packages"
echo "================================="
sudo apt update
PACKAGES=(
  curl wget git vim nano micro tree tmux screen htop
  jq yq ripgrep fd-find net-tools iproute2 dnsutils
  lsof strace tcpdump telnet netcat-openbsd unzip zip
  tar gzip xz-utils build-essential make cmake pkg-config
  ca-certificates gnupg bash-completion
  python3 python3-pip python3-venv openjdk-21-jdk
  postgresql-client-16 redis-tools sqlite3
)
for pkg in "${PACKAGES[@]}"; do
  if [[ "$pkg" == "fd-find" ]]; then
    if apt-cache show fdfind >/dev/null 2>&1; then
      echo "[INSTALL] fdfind (mapped from fd-find)"
      sudo apt install -y fdfind
      continue
    fi
  fi
  if apt-cache show "$pkg" >/dev/null 2>&1; then
    echo "[INSTALL] $pkg"
    sudo apt install -y "$pkg"
  else
    echo "[WARN] Debian mapping missing for: $pkg"
  fi
done
echo "✅ Debian base packages installed"
