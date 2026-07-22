#!/usr/bin/env bash
set -euo pipefail
echo "ARZIN Ubuntu Validation"
COMMANDS=(git curl wget micro tmux jq yq rg python3 java)
FAIL=0
for cmd in "${COMMANDS[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "[OK] $cmd"
  else
    echo "[FAIL] $cmd missing"
    FAIL=1
  fi
done
if [ -n "${JAVA_HOME:-}" ] && [ -d "$JAVA_HOME" ]; then
  echo "[OK] JAVA_HOME is set to $JAVA_HOME"
else
  echo "[FAIL] JAVA_HOME is not set or directory does not exist"
  FAIL=1
fi
exit $FAIL
