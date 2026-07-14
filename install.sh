#!/usr/bin/env bash
set -e

echo "========================================"
echo "      Installing ZINOVA Shell"
echo "========================================"

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_DIR="$REPO_DIR/config"

WORKSPACE_CONF="$CONFIG_DIR/workspace.conf"
COLORS_CONF="$CONFIG_DIR/colors.conf"
USER_CONF="$CONFIG_DIR/user.conf"
USER_TEMPLATE="$CONFIG_DIR/user.conf.example"

INIT_FILE="$HOME/.config/zinova-init.sh"
BASHRC="$HOME/.bashrc"

########################################
# Clean Previous Installation
########################################

echo
echo "[1/6] Cleaning previous installation..."

rm -f "$INIT_FILE"

if [ -f "$BASHRC" ]; then
    sed -i '/# ZINOVA Shell/,+1d' "$BASHRC"
fi

########################################
# Validate Configuration
########################################

echo
echo "[2/6] Checking configuration..."

for file in "$WORKSPACE_CONF" "$COLORS_CONF"
do
    if [ ! -f "$file" ]; then
        echo "[ERROR] Missing: $file"
        exit 1
    fi
done

if [ ! -f "$USER_CONF" ]; then

    echo "[INFO] user.conf not found."

    if [ -f "$USER_TEMPLATE" ]; then
        cp "$USER_TEMPLATE" "$USER_CONF"
        echo "[OK] Created config/user.conf from template."
    else
        touch "$USER_CONF"
        echo "[OK] Created empty config/user.conf"
    fi

fi

########################################
# Generate Loader
########################################

echo
echo "[3/6] Generating loader..."

mkdir -p "$HOME/.config"

cat > "$INIT_FILE" <<EOF
#!/usr/bin/env bash

export ZINOVA_SHELL_DIR="$REPO_DIR"

# Configuration
source "\$ZINOVA_SHELL_DIR/config/workspace.conf"
source "\$ZINOVA_SHELL_DIR/config/colors.conf"
source "\$ZINOVA_SHELL_DIR/config/user.conf"

# Modules
source "\$ZINOVA_SHELL_DIR/shell/theme.sh"
source "\$ZINOVA_SHELL_DIR/shell/context.sh"
source "\$ZINOVA_SHELL_DIR/shell/environment.sh"
source "\$ZINOVA_SHELL_DIR/shell/git.sh"
source "\$ZINOVA_SHELL_DIR/shell/aliases.sh"
source "\$ZINOVA_SHELL_DIR/shell/prompt.sh"

PROMPT_COMMAND="zinova_prompt"
EOF

chmod 644 "$INIT_FILE"

########################################
# Register Bash
########################################

echo
echo "[4/6] Registering shell..."

{
    echo
    echo "# ZINOVA Shell"
    echo "[ -f \"$INIT_FILE\" ] && source \"$INIT_FILE\""
} >> "$BASHRC"

########################################
# Validation
########################################

echo
echo "[5/6] Running validation..."

bash <<EOF
source "$INIT_FILE"

FAILED=0

check() {

    if type "\$1" >/dev/null 2>&1
    then
        printf "  [OK]   %s\n" "\$1"
    else
        printf "  [FAIL] %s\n" "\$1"
        FAILED=1
    fi

}

check zinova_prompt
check zinova_context
check zinova_environment

exit \$FAILED
EOF

########################################
# Finish
########################################

echo
echo "[6/6] Installation completed."

echo
echo "========================================"
echo " ZINOVA Shell installed successfully."
echo "========================================"

echo
echo "Repository:"
echo "  $REPO_DIR"

echo
echo "Configuration:"
echo "  config/workspace.conf"
echo "  config/colors.conf"
echo "  config/user.conf"

echo
echo "You can customize your environment by editing:"
echo
echo "  config/user.conf"

echo
echo "Launching ZINOVA Shell..."
echo

exec "\$SHELL" -l
