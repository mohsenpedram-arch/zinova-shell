#!/usr/bin/env bash
# ================================================================
# ARZIN PLATFORM BOOTSTRAP — ORCHESTRATOR v2.2
# ================================================================
set -euo pipefail

# بررسی دسترسی root
if [[ $EUID -ne 0 ]]; then
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║  ⚠️  THIS SCRIPT REQUIRES ROOT PRIVILEGES                  ║"
    echo "║                                                              ║"
    echo "║  Please run with:                                           ║"
    echo "║  sudo ./arzin-bootstrap.sh                                  ║"
    echo "║  or as root: su - && ./arzin-bootstrap.sh                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    exit 1
fi

VERSION="2.2"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$ROOT/logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/bootstrap-$(date +%Y%m%d-%H%M%S).log"
exec > >(tee -a "$LOG_FILE") 2>&1

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║          ARZIN PLATFORM BOOTSTRAP — ORCHESTRATOR           ║"
echo "║                      VERSION $VERSION                      ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo
echo "📂 ROOT: $ROOT"
echo "📋 LOG : $LOG_FILE"
echo

# تابع اجرای فازها
run_phase() {
    PHASE_NAME="$1"
    SCRIPT_PATH="$2"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "▶️  $PHASE_NAME"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    if [ -f "$ROOT/$SCRIPT_PATH" ]; then
        if bash -c "cd '$ROOT' && bash '$ROOT/$SCRIPT_PATH'"; then
            echo "✅ $PHASE_NAME — SUCCESS"
        else
            echo "❌ $PHASE_NAME — FAILED"
            echo "   Check log: $LOG_FILE"
            exit 1
        fi
    else
        echo "⚠️  $PHASE_NAME — SKIPPED (file not found: $SCRIPT_PATH)"
    fi
    echo
}

# PHASE 0: OS detection
source /etc/os-release
echo "✅ OS: ${ID} ${VERSION_ID}"

# PHASE 1-13
run_phase "PHASE 1 — OS Adapter" "os/detect.sh"
run_phase "PHASE 2 — Docker Engine" "runtime/docker/install.sh"
run_phase "PHASE 3 — Docker Configuration" "runtime/docker/configure.sh"
run_phase "PHASE 4 — Language Runtimes" "runtime/languages/install.sh"
run_phase "PHASE 5 — DB & Messaging Clients" "runtime/clients/install.sh"
run_phase "PHASE 6 — Kubernetes Tools" "runtime/kubernetes/install.sh developer"
run_phase "PHASE 7 — ARZIN CLI" "arzin-cli/bin/arzin"
run_phase "PHASE 8 — Manifest Engine" "installer/install-engine.sh"
run_phase "PHASE 9 — Infrastructure Runtime" "infrastructure/docker/start.sh"
run_phase "PHASE 10 — Profiles & Secrets" "security/profile-loader.sh developer"
run_phase "PHASE 11 — Service Factory" "factory/create-service.sh"
run_phase "PHASE 12 — Observability" "observability/docker/start.sh"
run_phase "PHASE 13 — CI/CD Factory" "cicd/install.sh"

echo "╔══════════════════════════════════════════════════════════════╗"
echo "║        ✅ ARZIN BOOTSTRAP ORCHESTRATION COMPLETED          ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo "📋 LOG: $LOG_FILE"
