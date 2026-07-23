#!/usr/bin/env bash
set -euo pipefail

SERVICE_NAME=${1:-}
if [ -z "$SERVICE_NAME" ]; then
    echo "Usage: arzin create-service <service-name>"
    exit 1
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_TARGET="$ROOT/../services/$SERVICE_NAME"
TARGET=${2:-$DEFAULT_TARGET}
TARGET="$(realpath -m "$TARGET")"

if [ -d "$TARGET" ]; then
    echo "[ERROR] Service already exists: $TARGET"
    exit 1
fi

echo "Creating ARZIN service: $SERVICE_NAME"
echo "Target: $TARGET"

mkdir -p "$TARGET"
cp -rT "$ROOT/service-template" "$TARGET"

# جایگزینی placeholders
find "$TARGET" -type f -exec sed -i "s/{{SERVICE_NAME}}/$SERVICE_NAME/g" {} \;
find "$TARGET" -type f -exec sed -i "s/{{SERVICE_NAME_LOWER}}/${SERVICE_NAME,,}/g" {} \;
find "$TARGET" -type f -exec sed -i "s/{{SERVICE_NAME_UPPER}}/${SERVICE_NAME^^}/g" {} \;

# حذف فایل‌های .tpl
find "$TARGET" -name "*.tpl" -exec sh -c 'mv "$0" "${0%.tpl}"' {} \;

echo
echo "[DONE] Service created"
echo "PATH: $TARGET"
echo
echo "📂 Structure:"
tree "$TARGET" -L 3 2>/dev/null || ls -la "$TARGET"
