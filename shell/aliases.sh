#!/usr/bin/env bash

#!/usr/bin/env bash

# =========================
# ZINOVA Workspace Navigation
# =========================


# Root

alias homez='cd ~'

alias ws='cd "$ZINOVA_WORKSPACES"'



# =========================
# ZINOVA
# =========================

alias zroot='cd "$ZINOVA_ROOT"'


alias cor='cd "$ZINOVA_ENGINE"'

alias plat='cd "$ZINOVA_PLATFORM"'



# =========================
# ZEIS / SHARED
# =========================

alias zis='cd "$ZINOVA_ZEIS"'

alias shared='cd "$ZINOVA_SHARED"'



# =========================
# ARZIN
# =========================

alias arz='cd "$ARZIN_CORE"'

alias arzs='cd "$ARZIN_SANDBOX"'



# =========================
# ZINOVA Sandbox
# =========================

alias cors='cd "$ZINOVA_CORE_SANDBOX"'

alias plats='cd "$ZINOVA_PLATFORM_SANDBOX"'


alias shell="cd $ZINOVA_SHELL_HOME"

# =========================
# Utilities
# =========================

# =========================
# Colorized LS
# =========================

alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'

alias c='clear'

alias ll='ls -lah'

alias la='ls -A'

alias lt='tree -L 2'

# =========================
# Quick System
# =========================

alias c='clear'
alias e='exit'

alias ll='ls -lah'
alias la='ls -A'
alias lt='tree -L 2'


# =========================
# Git
# =========================

alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'


# =========================
# Rust / Cargo
# =========================

alias cb='cargo build'
alias ct='cargo test'
alias cr='cargo run'


# =========================
# Python
# =========================

alias py='python3'
alias pip='pip3'


# =========================
# Update
# =========================

alias uu='sudo apt update && sudo apt upgrade -y'
