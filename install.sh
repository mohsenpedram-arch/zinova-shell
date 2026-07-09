#!/usr/bin/env bash
set -e

echo "========================================"
echo "      Installing ZINOVA Shell"
echo "========================================"

# Detect repository location automatically
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_DIR="$HOME/.config/zinova"
INIT_FILE="$CONFIG_DIR/init.sh"
BASHRC="$HOME/.bashrc"

mkdir -p "$CONFIG_DIR"

cat > "$INIT_FILE" <<EOL
#!/usr/bin/env bash

ZINOVA_SHELL_DIR="$REPO_DIR"

source "\$ZINOVA_SHELL_DIR/shell/theme.sh"
source "\$ZINOVA_SHELL_DIR/shell/context.sh"
source "\$ZINOVA_SHELL_DIR/shell/environment.sh"
source "\$ZINOVA_SHELL_DIR/shell/git.sh"
source "\$ZINOVA_SHELL_DIR/shell/aliases.sh"
source "\$ZINOVA_SHELL_DIR/shell/prompt.sh"

PROMPT_COMMAND=zinova_prompt
EOL

chmod +x "$INIT_FILE"

LINE='[ -f "$HOME/.config/zinova/init.sh" ] && source "$HOME/.config/zinova/init.sh"'

if ! grep -Fq "$LINE" "$BASHRC"; then
    {
        echo
        echo "# ZINOVA Shell"
        echo "$LINE"
    } >> "$BASHRC"
fi

# Load immediately
source "$INIT_FILE"

echo
echo "========================================"
echo " ZINOVA Shell installed successfully."
echo " Repository : $REPO_DIR"
echo " Config     : $INIT_FILE"
echo "========================================"
