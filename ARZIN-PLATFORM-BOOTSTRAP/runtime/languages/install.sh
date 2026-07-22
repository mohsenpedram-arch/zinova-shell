#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "================================="
echo " ARZIN Language Runtime Installer"
echo "================================="
echo "[1/5] Installing Java"
bash "$ROOT/java.sh"
echo "[2/5] Installing Kotlin"
echo "[2.5/5] Installing Gradle"
bash "$ROOT/gradle.sh"
bash "$ROOT/kotlin.sh"
echo "[3/5] Installing Python"
bash "$ROOT/python.sh"
echo "[4/5] Installing Rust"
bash "$ROOT/rust.sh"
echo
echo "✅ Language runtime installation completed"
