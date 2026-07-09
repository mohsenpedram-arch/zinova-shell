# Git aliases

#alias gs='git status'
#alias ga='git add'
#alias gaa='git add .'
#alias gc='git commit'
#alias gp='git push'
#alias gl='git log --oneline --graph --decorate --all'
#alias gd='git diff'
#alias gb='git branch'

#!/bin/bash

zinova_git_prompt() {

    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1
    then
        return
    fi

    local branch
    branch=$(git branch --show-current 2>/dev/null)

    if git diff --quiet && git diff --cached --quiet
    then
        echo "${CLR_GIT_OK}🟢 ${branch} ✓${CLR_RESET}"
    else
        echo "${CLR_GIT_BAD}🔴 ${branch} ✗${CLR_RESET}"
    fi

}
