#!/bin/bash

source ~/zinova-shell/shell/theme.sh
source ~/zinova-shell/shell/context.sh
source ~/zinova-shell/shell/environment.sh
source ~/zinova-shell/shell/git.sh

zinova_prompt() {

    local repo=$(zinova_context)
    local env=$(zinova_environment)
    local now=$(date "+%Y-%m-%d %H:%M:%S")

    local repo_color="$CLR_LOCAL"

    case "$repo" in
        WORKSPACE) repo_color="$CLR_WORKSPACE" ;;
        ENGINE)    repo_color="$CLR_ENGINE" ;;
        PLATFORM)  repo_color="$CLR_PLATFORM" ;;
        ZEIS)      repo_color="$CLR_ZEIS" ;;
        CORE)      repo_color="$CLR_WORKSPACE" ;;
        LOCAL)     repo_color="$CLR_LOCAL" ;;
    esac

   local git_info
    git_info=$(zinova_git_prompt)

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then

        local branch
        branch=$(git branch --show-current)

        if git diff --quiet && git diff --cached --quiet; then
            git_info="${CLR_GIT_OK}🟢 ${branch} ✓${CLR_RESET}"
        else
            git_info="${CLR_GIT_BAD}🔴 ${branch} ✗${CLR_RESET}"
        fi

    fi

    PS1="${CLR_TITLE}⚡ZINOVA ${repo_color}[${repo}|${env}] ${repo_color}⌚${now} ${USER} in ${PWD}${CLR_RESET}"

    if [ -n "$git_info" ]; then
        PS1="${PS1}\n${git_info}\n\$ "
    else
        PS1="${PS1}\n\$ "
    fi

}
