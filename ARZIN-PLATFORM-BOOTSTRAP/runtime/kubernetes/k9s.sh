#!/usr/bin/env bash
set -euo pipefail
echo "Installing k9s"

if command -v k9s >/dev/null 2>&1; then
    echo "[OK] k9s exists"
    exit 0
fi

ARCH=$(uname -m)
case "$ARCH" in
  x86_64)  K9S_ARCH="amd64" ;;
  aarch64) K9S_ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

VERSION=$(curl -s https://api.github.com/repos/derailed/k9s/releases/latest | jq -r .tag_name)
curl -LO "https://github.com/derailed/k9s/releases/download/${VERSION}/k9s_Linux_${K9S_ARCH}.tar.gz"
tar -xzf "k9s_Linux_${K9S_ARCH}.tar.gz" k9s
sudo mv k9s /usr/local/bin/
k9s version
echo "[DONE] k9s installed"
