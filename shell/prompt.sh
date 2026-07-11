#!/usr/bin/env bash

zinova_prompt() {

    local repo
    repo=$(zinova_context)

    local env
    env=$(zinova_environment)

    local now
    now=$(date "+%Y-%m-%d %H:%M:%S")

    local repo_color=""
    local text_color=""
    local prefix=""
    local prefix_color=""

    case "$repo" in
        ZEIS)
            prefix="⚡ZINOVA"
            prefix_color="$CLR_ZINOVA"
            text_color="$CLR_ZEIS"
            repo_color="$CLR_ZEIS"
            ;;
        CORE)
            prefix="⚡ZINOVA"
            prefix_color="$CLR_ZINOVA"
            text_color="$CLR_CORE"
            repo_color="$CLR_CORE"
            ;;
        PLATFORM)
            prefix="⚡ZINOVA"
            prefix_color="$CLR_ZINOVA"
            text_color="$CLR_PLATFORM"
            repo_color="$CLR_PLATFORM"
            ;;
        SHELL)
            prefix="🖼️ ZINOVA.SHELL"
            prefix_color="$CLR_SHELL"
            text_color="$CLR_SHELL_TEXT"
            repo_color="$CLR_SHELL"
            ;;
        ARZIN)
            prefix="💰 ARZIN"
            prefix_color="$CLR_ARZIN"
            text_color="$CLR_ARZIN_TEXT"
            repo_color="$CLR_ARZIN"
            ;;
        *)
            prefix="⚡ZINOVA"
            prefix_color="$CLR_ZINOVA"
            text_color="$CLR_ZEIS"
            repo_color="$CLR_ZEIS"
            ;;
    esac

    # اگر سندباکس است، prefix ⚡ZINOVA با رنگ سبز
    if [[ "$env" == "SBX" ]]; then
        prefix="⚡ZINOVA"
        prefix_color="$CLR_ZINOVA"
        # رنگ متن برای سندباکس‌ها
        if [[ "$repo" == "CORE" ]] || [[ "$repo" == "COR" ]]; then
            text_color="$CLR_CORE"
        elif [[ "$repo" == "PLATFORM" ]]; then
            text_color="$CLR_PLATFORM"
        else
            text_color="$CLR_ZEIS"
        fi
    fi

    # git status
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

    # ساخت پرامپت با رنگ‌های جداگانه
    PS1="${prefix_color}${prefix} ${text_color}[${repo}|${env}] ${text_color}⌚${now} ${USER} in ${PWD}${CLR_RESET}"

    if [ -n "$git_info" ]; then
        PS1="${PS1}\n${git_info}\n\\$ "
    else
        PS1="${PS1}\n\\$ "
    fi
}
