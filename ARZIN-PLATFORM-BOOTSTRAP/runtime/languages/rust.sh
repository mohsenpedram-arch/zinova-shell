#!/usr/bin/env bash
set -euo pipefail
echo "Installing Rust Stable"

if command -v rustc >/dev/null 2>&1; then
    echo "[OK] Rust already installed"
    exit 0
fi

curl -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"
rustup default stable
rustup component add rustfmt
rustup component add clippy

# فعال‌سازی دائم
grep -q 'source "$HOME/.cargo/env"' ~/.bashrc || echo 'source "$HOME/.cargo/env"' >> ~/.bashrc

echo "[DONE] Rust ready"
echo "[INFO] Please restart your shell or run: source ~/.bashrc"
