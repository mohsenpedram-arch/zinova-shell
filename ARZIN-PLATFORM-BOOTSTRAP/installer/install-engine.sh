#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export ARZIN_HOME="$ROOT/arzin-cli"
source "$ARZIN_HOME/core/config.sh"
source "$ARZIN_HOME/core/logger.sh"

echo "================================="
echo " ARZIN MANIFEST INSTALL ENGINE"
echo "================================="

if ! command -v yq >/dev/null 2>&1; then
    fail "yq is required (sudo apt install yq)"
    exit 1
fi

PLATFORM=$(yq '.platform.name' "$MANIFEST_FILE")
VERSION=$(yq '.platform.version' "$MANIFEST_FILE")
PROFILE=${ARZIN_PROFILE:-developer}

info "Platform : $PLATFORM"
info "Version  : $VERSION"
info "Profile  : $PROFILE"

bash "$ROOT/installer/package-resolver.sh" "$PROFILE"
bash "$ROOT/installer/version-check.sh"
bash "$ROOT/installer/report.sh"

echo "✅ Manifest-driven installation completed"
