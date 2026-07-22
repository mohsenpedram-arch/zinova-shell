#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN Docker Configuration"
echo "================================="

USER_NAME=${SUDO_USER:-$USER}
echo "[INFO] Adding user to docker group"
sudo usermod -aG docker "$USER_NAME"

echo "[INFO] Enabling Docker service"
sudo systemctl enable docker
sudo systemctl restart docker

echo "[INFO] Docker daemon status"
sudo systemctl status docker --no-pager

echo
echo "IMPORTANT:"
echo "Logout/Login required for docker group activation"
