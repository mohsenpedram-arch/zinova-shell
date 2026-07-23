#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$ARZIN_HOME/.." && pwd)"
bash "$ROOT/infrastructure/docker/stop.sh"
