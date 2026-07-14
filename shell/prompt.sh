#!/usr/bin/env bash

zinova_prompt() {

    local repo
    repo=$(zinova_context)

    local env
    env=$(zinova_environment)

    local now
    now=$(date "+%Y-%m-%d %H:%M:%S")

    local repo_color="$CLR_LOCAL"

    case "$repo" in

        WORKSPACE)
            repo_color="$CLR_WORKSPACE"
        ;;

        ENGINE)
            repo_color="$CLR_ENGINE"
        ;;

        PLATFORM)
            repo_color="$CLR_PLATFORM"
        ;;

        ZEIS)
            repo_color="$CLR_ZEIS"
        ;;

        ARZIN)
            repo_color="$CLR_ARZIN"
        ;;

        CORE)
            repo_color="$CLR_WORKSPACE"
        ;;

        LOCAL)
            repo_color="$CLR_LOCAL"
        ;;

    esac


    local git_info=""

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then

        local branch
        branch=$(git branch --show-current 2>/dev/null)

        if git diff --quiet && git diff --cached --quiet; then
            git_info="${CLR_GIT_OK}🟢 ${branch} ✓${CLR_RESET}"
        else
            git_info="${CLR_GIT_BAD}🔴 ${branch} ✗${CLR_RESET}"
        fi

    fi


    PS1="${CLR_TITLE}⚡ZINOVA ${repo_color}[${repo}|${env}] ${repo_color}⌚${now} ${USER} in ${PWD}${CLR_RESET}"


    if [ -n "$git_info" ]; then
        PS1="${PS1}\n${git_info}\n\\$ "
    else
        PS1="${PS1}\n\\$ "
    fi

}
