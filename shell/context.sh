#!/bin/bash

zinova_context() {

local dir="$PWD"

case "$dir" in

*/ZINOVA-CORE/ZEIS*)
    echo "ZEIS"
;;

*/ZINOVA-CORE/zinova-platform*)
    echo "PLATFORM"
;;

*/ZINOVA-CORE/zinova-core*)
    echo "ENGINE"
;;

*/ZINOVA-CORE)
    echo "WORKSPACE"
;;

*/ZINOVA-CORE-QA*)
    echo "CORE"
;;

*/ZINOVA-CORE-SANDBOX*)
    echo "CORE"
;;

*/ZINOVA-PLATFORM-QA*)
    echo "PLATFORM"
;;

*/ZINOVA-PLATFORM-SANDBOX*)
    echo "PLATFORM"
;;

*/ZINOVA-CORE*)
    echo "CORE"
;;

*)
    echo "LOCAL"
;;

esac

}

#-------------
zinova_context_color() {

local repo=$(zinova_context)

case "$repo" in

WORKSPACE)
    REPO_COLOR="$CLR_WORKSPACE"
;;

ENGINE)
    REPO_COLOR="$CLR_ENGINE"
;;

PLATFORM)
    REPO_COLOR="$CLR_PLATFORM"
;;

ZEIS)
    REPO_COLOR="$CLR_ZEIS"
;;

LOCAL)
    REPO_COLOR="$CLR_LOCAL"
;;

*)
    REPO_COLOR="$CLR_LOCAL"
;;

esac

}
