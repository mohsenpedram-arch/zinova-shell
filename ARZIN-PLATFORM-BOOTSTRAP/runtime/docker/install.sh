#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Docker Runtime Installer"
echo "================================="

if command -v docker >/dev/null 2>&1; then
    echo "[INFO] Docker already installed"
    docker --version
    exit 0
fi

echo "[INFO] Removing old Docker packages"
sudo apt remove -y \
    docker \
    docker-engine \
    docker.io \
    containerd \
    runc \
    2>/dev/null || true

echo "[INFO] Installing prerequisites"
sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "[INFO] Adding Docker repository"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo $ID)/gpg \
    | sudo gpg --dearmor \
    -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/$(. /etc/os-release && echo $ID) \
$(. /etc/os-release && echo $VERSION_CODENAME) stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

echo "[INFO] Installing Docker Engine"
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "[DONE] Docker installed"
docker --version
docker compose version
