#!/usr/bin/env bash


zinova_environment(){

local dir="$PWD"


case "$dir" in


*/ZINOVA-CORE-SANDBOX*)
    echo "SBX"
;;

*/ZINOVA-PLATFORM-SANDBOX*)
    echo "SBX"
;;

*/ARZIN-CORE*)
    echo "DEV"
;;

*)
    echo "DEV"
;;

esac

}
