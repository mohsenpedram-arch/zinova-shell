#!/usr/bin/env bash
source "$ARZIN_HOME/core/config.sh"
manifest_get() {
    KEY=$1
    if command -v yq >/dev/null 2>&1; then
        yq ".$KEY" "$MANIFEST_FILE"
    else
        echo "yq required" >&2
        exit 1
    fi
}
