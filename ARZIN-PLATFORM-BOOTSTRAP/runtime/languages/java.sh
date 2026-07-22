#!/usr/bin/env bash
set -euo pipefail
echo "Installing OpenJDK 21"

if java -version 2>&1 | grep -q "21"; then
    echo "[OK] Java 21 already installed"
    exit 0
fi

sudo apt update
sudo apt install -y openjdk-21-jdk

JAVA_PATH=$(dirname $(dirname $(readlink -f $(which java))))
echo "export JAVA_HOME=$JAVA_PATH" | sudo tee /etc/profile.d/arzin-java.sh
echo "export PATH=\$JAVA_HOME/bin:\$PATH" | sudo tee -a /etc/profile.d/arzin-java.sh

echo "[DONE] Java 21 configured"
echo "[INFO] Please restart your shell or run: source /etc/profile.d/arzin-java.sh"
