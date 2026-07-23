
#!/usr/bin/env bash

set -euo pipefail

ARZIN_VERSION="1.0.0"
STATE_DIR="/var/lib/arzin"
STATE_FILE="$STATE_DIR/bootstrap.state"
LOG_FILE="/var/log/arzin-bootstrap.log"

mkdir -p "$STATE_DIR"

exec > >(tee -a "$LOG_FILE") 2>&1


echo "================================================"
echo " ARZIN PLATFORM BOOTSTRAP v$ARZIN_VERSION"
echo "================================================"


if [ "$(id -u)" -ne 0 ]; then
    echo "[FAILED] Run as root"
    exit 1
fi


echo "[OK] ROOT user"


if [ ! -f /etc/os-release ]; then
    echo "[FAILED] Unknown OS"
    exit 1
fi


source /etc/os-release


case "$ID" in
    ubuntu)
        OS="ubuntu"
        ;;
    debian)
        OS="debian"
        ;;
    *)
        echo "[FAILED] Unsupported OS: $ID"
        exit 1
        ;;
esac


echo "[OS] $OS $VERSION_ID"


if grep -qi microsoft /proc/version || grep -qi wsl /proc/version; then
    ENVIRONMENT="WSL"
else
    ENVIRONMENT="LINUX"
fi


echo "[ENVIRONMENT] $ENVIRONMENT"


apt_update()
{
    if [ ! -f "$STATE_DIR/apt.updated" ]; then
        echo "[INSTALLING] apt index"
        apt-get update -y
        touch "$STATE_DIR/apt.updated"
    else
        echo "[ALREADY DONE] apt update"
    fi
}


package_installed()
{
    dpkg -s "$1" >/dev/null 2>&1
}


install_package()
{
    PKG="$1"

    if package_installed "$PKG"; then
        echo "[ALREADY INSTALLED] $PKG"
    else
        echo "[INSTALLING] $PKG"
        apt-get install -y "$PKG"
    fi
}


command_installed()
{
    command -v "$1" >/dev/null 2>&1
}


run_phase()
{
    PHASE="$1"

    if grep -q "$PHASE=done" "$STATE_FILE" 2>/dev/null; then
        echo "[SKIP] $PHASE already completed"
        return
    fi

    echo "========== $PHASE =========="

    case "$PHASE" in


PHASE_01_OS)
    echo "[CHECK] OS Adapter"
    ;;


PHASE_02_RUNTIME)

    install_package openjdk-21-jdk
    install_package python3
    install_package python3-pip
    install_package python3-venv

    if command_installed rustc; then
        echo "[ALREADY INSTALLED] Rust"
    else
        echo "[INSTALLING] Rust"
        curl https://sh.rustup.rs -sSf | sh -s -- -y
    fi

    ;;


PHASE_03_TOOLCHAIN)

    TOOLS=(
    curl wget git micro vim nano tree tmux
    screen htop jq yq ripgrep fd-find
    net-tools iproute2 dnsutils lsof
    strace tcpdump unzip zip tar gzip
    xz-utils build-essential make cmake
    pkg-config ca-certificates gnupg
    lsb-release bash-completion
    )

    for tool in "${TOOLS[@]}"; do
        install_package "$tool"
    done

    ;;


PHASE_04_CONTAINER)

    if command_installed docker; then
        echo "[ALREADY INSTALLED] docker"
    else
        echo "[INSTALLING] docker"
        apt-get install -y docker.io
    fi


    if docker info >/dev/null 2>&1; then
        echo "[READY] docker daemon"
    else
        echo "[WARNING] docker daemon unavailable"
    fi


    if command_installed docker-compose; then
        echo "[ALREADY INSTALLED] docker-compose"
    else
        apt-get install -y docker-compose-plugin || true
    fi

    ;;


PHASE_05_CLI)

    mkdir -p /opt/arzin/bin
    echo "[READY] ARZIN CLI directory"
    ;;


PHASE_06_MANIFEST)

    mkdir -p /opt/arzin/manifest
    echo "[READY] Manifest Engine"
    ;;


PHASE_07_INFRASTRUCTURE)

    mkdir -p /opt/arzin/infrastructure
    echo "[READY] Infrastructure Manager"
    ;;


PHASE_08_SECURITY)

    mkdir -p /opt/arzin/secrets
    chmod 700 /opt/arzin/secrets
    echo "[READY] Security Profile"
    ;;


PHASE_09_FACTORY)

    mkdir -p /opt/arzin/factory
    echo "[READY] Service Factory"
    ;;


PHASE_10_OBSERVABILITY)

    mkdir -p /opt/arzin/observability
    echo "[READY] Observability"
    ;;


PHASE_11_CICD)

    mkdir -p /opt/arzin/cicd
    echo "[READY] CI/CD Factory"
    ;;


    esac


    echo "$PHASE=done" >> "$STATE_FILE"
}



apt_update


run_phase PHASE_01_OS
run_phase PHASE_02_RUNTIME
run_phase PHASE_03_TOOLCHAIN
run_phase PHASE_04_CONTAINER
run_phase PHASE_05_CLI
run_phase PHASE_06_MANIFEST
run_phase PHASE_07_INFRASTRUCTURE
run_phase PHASE_08_SECURITY
run_phase PHASE_09_FACTORY
run_phase PHASE_10_OBSERVABILITY
run_phase PHASE_11_CICD


echo
echo "================================================"
echo " ARZIN BOOTSTRAP COMPLETE"
echo "================================================"

echo "STATE:"
echo "$STATE_FILE"

EOF


chmod +x arzin-bootstrap.sh
