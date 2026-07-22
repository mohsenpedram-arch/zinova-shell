#!/usr/bin/env bash
set -euo pipefail
PROFILE=${1:-developer}
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE_FILE="$ROOT/profiles/${PROFILE}.env"

if [ ! -f "$PROFILE_FILE" ]; then
    echo "[ERROR] Profile not found: $PROFILE"
    echo "Available: developer, integration, production"
    exit 1
fi

echo "[INFO] Loading profile: $PROFILE"
set -a
source "$PROFILE_FILE"
set +a
echo "[OK] Profile loaded: ARZIN_PROFILE=$ARZIN_PROFILE"
