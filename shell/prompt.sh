#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/theme.sh"


zinova_prompt() {

    local repo
    repo=$(zinova_context)

    local env
    env=$(zinova_environment)

    local now
    now=$(date "+%Y-%m-%d %H:%M:%S")


    # ==========================================================
    # Brand Identity
    # ==========================================================

    local brand
    local brand_icon
    local brand_color
    local repo_color


    case "$repo" in

        ARZIN)
            brand="ARZIN"
            brand_icon="$ICON_ARZIN"
            brand_color="$CLR_ARZIN"
            repo_color="$CLR_ARZIN"
            ;;

        ZEIS)
            brand="ZEIS"
            brand_icon="$ICON_ZEIS"
            brand_color="$CLR_ZEIS"
            repo_color="$CLR_ZEIS"
            ;;

        SHELL)
            brand="SHELL"
            brand_icon="$ICON_SHELL"
            brand_color="$CLR_SHELL"
            repo_color="$CLR_SHELL"
            ;;

        PLATFORM)
            brand="ZINOVA"
            brand_icon="$ICON_ZINOVA"
            brand_color="$CLR_ZINOVA"
            repo_color="$CLR_PLATFORM"
            ;;

        ENGINE)
            brand="ZINOVA"
            brand_icon="$ICON_ZINOVA"
            brand_color="$CLR_ZINOVA"
            repo_color="$CLR_CORE"
            ;;

        CORE)
            brand="ZINOVA"
            brand_icon="$ICON_ZINOVA"
            brand_color="$CLR_ZINOVA"
            repo_color="$CLR_CORE"
            ;;

        WORKSPACE)
            brand="ZINOVA"
            brand_icon="$ICON_ZINOVA"
            brand_color="$CLR_ZINOVA"
            repo_color="$CLR_LOCAL"
            ;;

        *)
            brand="ZINOVA"
            brand_icon="$ICON_ZINOVA"
            brand_color="$CLR_ZINOVA"
            repo_color="$CLR_LOCAL"
            ;;

    esac



    # ==========================================================
    # Git Status
    # ==========================================================

    local git_info=""

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then

        local branch
        branch=$(git branch --show-current 2>/dev/null)


        if git diff --quiet && git diff --cached --quiet; then

            git_info="${CLR_GIT_OK}${ICON_OK} ${branch} ✓${CLR_RESET}"

        else

            git_info="${CLR_GIT_BAD}${ICON_BAD} ${branch} ✗${CLR_RESET}"

        fi

    fi



    # ==========================================================
    # Prompt Render
    # ==========================================================

    PS1="${brand_color}${brand_icon}${brand}${CLR_RESET} ${repo_color}[${repo}${CLR_RESET}|${CLR_DEV}${env}${CLR_RESET}] ${CLR_TIME}⌚${now}${CLR_RESET} ${CLR_USER}${USER}${CLR_RESET} in ${CLR_PATH}${PWD}${CLR_RESET}"


    if [ -n "$git_info" ]; then

        PS1="${PS1}\n${git_info}\n\\$ "

    else

        PS1="${PS1}\n\\$ "

    fi

}


PROMPT_COMMAND=zinova_prompt
