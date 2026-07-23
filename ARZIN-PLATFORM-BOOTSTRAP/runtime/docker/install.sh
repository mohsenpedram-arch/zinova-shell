#!/usr/bin/env bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "========== PHASE 3 DOCKER =========="

if command_exists docker; then
    echo "[ALREADY INSTALLED] Docker"
else
    echo "[INSTALLING] Docker"
    apt-get install -y docker.io
fi

if command_exists systemctl; then
    systemctl enable docker || true
    systemctl start docker || true
fi

echo "[CHECK] Docker daemon"
if docker info >/dev/null 2>&1; then
    echo "[OK] Docker daemon running"
else
    echo "[WARNING] Docker installed but daemon unavailable"
    if command_exists service; then
        service docker start || true
    fi
    sleep 5
    if docker info >/dev/null 2>&1; then
        echo "[OK] Docker daemon started"
    else
        echo "[ERROR] Docker daemon still unavailable"
        echo "Check:"
        echo "systemctl status docker"
        echo "service docker status"
        exit 1
    fi
fi

if docker compose version >/dev/null 2>&1; then
    echo "[ALREADY INSTALLED] Docker Compose"
else
    echo "[INSTALLING] Docker Compose"
    apt-get install -y docker-compose-plugin
fi
