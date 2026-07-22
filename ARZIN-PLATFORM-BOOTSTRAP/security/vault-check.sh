#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN VAULT CHECK"
echo "================================="

if command -v vault >/dev/null 2>&1; then
    echo "[OK] Vault CLI installed"
    echo "Version: $(vault version | head -1)"
    
    if [ -n "${VAULT_ADDR:-}" ]; then
        echo "[INFO] VAULT_ADDR: $VAULT_ADDR"
        if vault status >/dev/null 2>&1; then
            echo "[OK] Vault server is reachable"
            vault status | head -3
        else
            echo "[WARN] Vault server not reachable or not initialized"
        fi
    else
        echo "[WARN] VAULT_ADDR not set"
    fi
else
    echo "[FAIL] Vault CLI not installed"
    echo "Install from: https://developer.hashicorp.com/vault/downloads"
    exit 1
fi
