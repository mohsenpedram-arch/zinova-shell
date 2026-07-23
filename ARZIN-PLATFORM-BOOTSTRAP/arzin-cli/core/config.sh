#!/usr/bin/env bash
BOOTSTRAP_ROOT="$(cd "$ARZIN_HOME/.." && pwd)"
export MANIFEST_FILE="$BOOTSTRAP_ROOT/manifest/arzin-platform.yaml"
export ARZIN_PROFILE=${ARZIN_PROFILE:-developer}
