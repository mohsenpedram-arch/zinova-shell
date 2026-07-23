#!/usr/bin/env bash
set -euo pipefail
REPORT_DIR="/var/log/arzin"
sudo mkdir -p "$REPORT_DIR"
REPORT="$REPORT_DIR/install-report.log"

{
    echo "================================"
    echo " ARZIN INSTALL REPORT"
    echo " DATE: $(date)"
    echo "================================"
    echo
    echo "OS:"; cat /etc/os-release
    echo
    echo "Kernel:"; uname -a
    echo
    echo "User:"; whoami
    echo
    echo "Docker:"; docker --version || true
    echo
    echo "Java:"; java -version 2>&1 || true
    echo
    echo "Python:"; python3 --version || true
    echo
    echo "Rust:"; rustc --version || true
} | sudo tee "$REPORT"

echo "✅ Report saved: $REPORT"
