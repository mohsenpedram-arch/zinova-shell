#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$ARZIN_HOME/.." && pwd)"
echo "================================="
echo " ARZIN INSTALL"
echo "================================="
bash "$ROOT/os/detect.sh"
bash "$ROOT/installer/install-engine.sh"
echo "✅ ARZIN installation finished"
