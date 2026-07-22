#!/usr/bin/env bash
set -euo pipefail
echo "Installing Kotlin 2.0"

if command -v kotlinc >/dev/null 2>&1 && kotlinc -version 2>&1 | grep -q "2.0"; then
    echo "[OK] Kotlin 2.0 already installed"
    exit 0
fi

# نصب با SDKMAN یا tarball
if command -v sdk >/dev/null 2>&1; then
    sdk install kotlin 2.0.0
else
    cd /tmp
    wget -q https://github.com/JetBrains/kotlin/releases/download/v2.0.0/kotlin-compiler-2.0.0.zip
    sudo unzip -q kotlin-compiler-2.0.0.zip -d /opt/kotlin
    sudo ln -sf /opt/kotlin/kotlinc/bin/kotlinc /usr/local/bin/kotlinc
    sudo ln -sf /opt/kotlin/kotlinc/bin/kotlin /usr/local/bin/kotlin
    rm -f kotlin-compiler-2.0.0.zip
fi
echo "[DONE] Kotlin 2.0 installed"
