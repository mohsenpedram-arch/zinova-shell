#!/bin/bash

echo "========================================"
echo "     Uninstalling ZINOVA Shell"
echo "========================================"

CONFIG_DIR="$HOME/.config/zinova"
BASHRC="$HOME/.bashrc"

LINE='[ -f "$HOME/.config/zinova/init.sh" ] && source "$HOME/.config/zinova/init.sh"'

rm -rf "$CONFIG_DIR"

if grep -Fq "$LINE" "$BASHRC"; then
    grep -Fv "$LINE" "$BASHRC" > "$BASHRC.tmp"
    mv "$BASHRC.tmp" "$BASHRC"
fi

unset PROMPT_COMMAND

echo ""
echo "✔ ZINOVA Shell Uninstalled Successfully"
echo ""
echo "Restart your terminal."
