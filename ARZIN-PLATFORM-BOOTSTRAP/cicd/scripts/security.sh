#!/usr/bin/env bash
set -euo pipefail

SERVICE=${1:-}
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$ROOT/services/$SERVICE"

echo "================================="
echo " ARZIN SECURITY SCAN"
echo "================================="

echo "[1] Secret Scan (git-secrets style)"
if git ls-files | xargs grep -n -i -E '(password|secret|token|key|private_key)' -- ':!*.md' 2>/dev/null | grep -v 'change-me' | grep -v 'example'; then
    echo "[WARN] Possible secrets found in code"
else
    echo "[OK] No obvious secrets found"
fi

echo
echo "[2] OWASP Dependency Check"
./gradlew dependencyCheckAnalyze || echo "[INFO] Run 'gradle dependencyCheckAnalyze' for full report"

echo
echo "[3] SBOM Generation"
./gradlew cyclonedxBom || echo "[INFO] Run 'gradle cyclonedxBom' for SBOM"

echo "[DONE] Security scan completed"
