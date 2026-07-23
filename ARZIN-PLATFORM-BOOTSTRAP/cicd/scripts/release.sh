#!/usr/bin/env bash
set -euo pipefail

SERVICE=${1:-}
VERSION=${2:-}
if [ -z "$SERVICE" ] || [ -z "$VERSION" ]; then
    echo "Usage: release.sh <service> <version>"
    exit 1
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
mkdir -p "$ROOT/releases/$SERVICE"

cat > "$ROOT/releases/$SERVICE/$VERSION.yaml" << YAML
service: $SERVICE
version: $VERSION
created: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
status: ready
image: arzin/$SERVICE:$VERSION
YAML

echo "[OK] Release metadata created: releases/$SERVICE/$VERSION.yaml"
