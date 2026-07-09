#!/bin/bash

echo "========================================"
echo "      Installing ZINOVA Shell"
echo "========================================"

CONFIG_DIR="$HOME/.config/zinova"
INIT_FILE="$CONFIG_DIR/init.sh"
BASHRC="$HOME/.bashrc"

mkdir -p "$CONFIG_DIR"

cat > "$INIT_FILE" <<'EOF'
#!/bin/bash

source ~/zinova-shell/shell/theme.sh
source ~/zinova-shell/shell/context.sh
source ~/zinova-shell/shell/environment.sh
source ~/zinova-shell/shell/git.sh
source ~/zinova-shell/shell/aliases.sh
source ~/zinova-shell/shell/prompt.sh

PROMPT_COMMAND=zinova_prompt
EOF

chmod +x "$INIT_FILE"

LINE='[ -f "$HOME/.config/zinova/init.sh" ] && source "$HOME/.config/zinova/init.sh"'

if ! grep -Fq "$LINE" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "# ZINOVA Shell" >> "$BASHRC"
    echo "$LINE" >> "$BASHRC"
fi

source "$INIT_FILE"

echo ""
echo "✔ ZINOVA Shell Installed Successfully"
