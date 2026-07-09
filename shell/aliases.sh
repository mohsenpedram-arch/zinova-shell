
# =========================
# ZINOVA Navigation Aliases
# =========================

# Workspace Root
alias zc='cd ~/ZINOVA-CORE'

# Main Repositories
alias cor='cd ~/ZINOVA-CORE/zinova-core'
alias plat='cd ~/ZINOVA-CORE/zinova-platform'
alias zis='cd ~/ZINOVA-CORE/ZEIS'

# QA / Sandbox
alias corq='cd ~/ZINOVA-CORE-QA'
alias cors='cd ~/ZINOVA-CORE-SANDBOX'

alias platq='cd ~/ZINOVA-PLATFORM-QA'
alias plats='cd ~/ZINOVA-PLATFORM-SANDBOX'

# Quick root locations
alias homez='cd ~'

#!/usr/bin/env bash

# =========================
# Shortcuts
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
# Python
# =========================

alias py='python3'
alias pip='pip3'

# =========================
# Cargo
# =========================

alias cb='cargo build'
alias ct='cargo test'
alias cr='cargo run'

# =========================
# Update
# =========================

alias uu='sudo apt update && sudo apt upgrade -y'
