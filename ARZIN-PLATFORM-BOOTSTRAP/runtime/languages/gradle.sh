#!/usr/bin/env bash
set -euo pipefail
echo "Installing Gradle 8.10"

if command -v gradle >/dev/null 2>&1 && gradle --version 2>&1 | grep -q "8.10"; then
    echo "[OK] Gradle 8.10 already installed"
    exit 0
fi

cd /tmp
wget -q https://services.gradle.org/distributions/gradle-8.10-bin.zip
sudo unzip -q gradle-8.10-bin.zip -d /opt/gradle
sudo ln -sf /opt/gradle/gradle-8.10/bin/gradle /usr/local/bin/gradle
rm -f gradle-8.10-bin.zip
echo "[DONE] Gradle 8.10 installed"
