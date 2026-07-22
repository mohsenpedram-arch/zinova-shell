#!/usr/bin/env bash
set -euo pipefail
PROFILE=${1:-developer}
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "================================="
echo " ARZIN Kubernetes Tool Installer"
echo " PROFILE: $PROFILE"
echo "================================="

case "$PROFILE" in
  developer)
    echo "[INFO] Kubernetes tools disabled for developer profile"
    exit 0
    ;;
  integration|production)
    echo "[INFO] Installing Kubernetes tools"
    bash "$ROOT/kubectl.sh"
    bash "$ROOT/helm.sh"
    bash "$ROOT/k9s.sh"
    ;;
  *)
    echo "[ERROR] Unknown profile: $PROFILE"
    exit 1
    ;;
esac
echo "[DONE] Kubernetes tools ready"
