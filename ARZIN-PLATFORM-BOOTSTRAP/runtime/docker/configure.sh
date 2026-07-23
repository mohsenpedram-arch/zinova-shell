#!/usr/bin/env bash
set -euo pipefail

echo "================================="
echo " ARZIN Docker Configuration"
echo "================================="

USER_NAME=${SUDO_USER:-$USER}
echo "[INFO] Current user: $USER_NAME"

# افزودن کاربر به گروه docker
if command -v usermod >/dev/null 2>&1; then
    echo "[INFO] Adding user to docker group"
    usermod -aG docker "$USER_NAME" 2>/dev/null || echo "[WARN] Could not add user to docker group"
else
    echo "[WARN] usermod not available"
fi

# بررسی وجود systemd
if [ -d /run/systemd/system ]; then
    echo "[INFO] systemd detected, enabling Docker service"
    systemctl enable docker 2>/dev/null || echo "[WARN] Could not enable docker"
    systemctl restart docker 2>/dev/null || echo "[WARN] Could not restart docker"
    systemctl status docker --no-pager 2>/dev/null || echo "[WARN] Could not get docker status"
else
    echo "[INFO] No systemd detected (WSL/Container environment)"
    echo "[INFO] Docker service should be started manually if needed"
    echo "[INFO] Run: service docker start 2>/dev/null || dockerd &"
fi

echo "================================="
echo " Docker Configuration Completed"
echo "================================="
