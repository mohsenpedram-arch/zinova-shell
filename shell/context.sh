#!/usr/bin/env bash


zinova_context() {

local dir="$PWD"


case "$dir" in


*/WORKSPACES/SHARED/ZEIS*)
    echo "ZEIS"
;;


*/WORKSPACES/ZINOVA/zinova-platform*)
    echo "PLATFORM"
;;


*/WORKSPACES/ZINOVA/zinova-core*)
    echo "ENGINE"
;;


*/WORKSPACES/ZINOVA*)
    echo "WORKSPACE"
;;


*/WORKSPACES/ARZIN*)
    echo "ARZIN"
;;


*)
    echo "LOCAL"
;;

esac

}
