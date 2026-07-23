#!/usr/bin/env bash
set -euo pipefail

echo "================================================="
echo " Kotlin & Gradle"
echo "================================================="

# ==================================================
# Gradle
# ==================================================

if command -v gradle >/dev/null 2>&1 && gradle --version | grep -q "8.10"; then
    echo "[OK] Gradle 8.10 already installed"
else
    echo "[INSTALL] Gradle 8.10"
    cd /tmp
    wget -q https://services.gradle.org/distributions/gradle-8.10-bin.zip
    sudo unzip -q gradle-8.10-bin.zip -d /opt/gradle
    sudo ln -sf /opt/gradle/gradle-8.10/bin/gradle /usr/local/bin/gradle
    rm -f gradle-8.10-bin.zip
fi

# ==================================================
# Kotlin
# ==================================================

if command -v kotlinc >/dev/null 2>&1 && kotlinc -version 2>&1 | grep -q "2.0"; then
    echo "[OK] Kotlin 2.0 already installed"
else
    echo "[INSTALL] Kotlin 2.0"
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
fi

echo "================================================="
echo " Kotlin & Gradle ready"
echo "================================================="
