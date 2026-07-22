#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$ARZIN_HOME/.." && pwd)"
PROFILE=${1:-developer}
bash "$ROOT/security/profile-loader.sh" "$PROFILE"
