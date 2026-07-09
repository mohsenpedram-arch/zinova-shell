#!/bin/bash

zinova_environment() {

local dir="$PWD"

case "$dir" in

*/ZINOVA-CORE-QA*)
    echo "QA"
;;

*/ZINOVA-CORE-SANDBOX*)
    echo "SBX"
;;

*/ZINOVA-PLATFORM-QA*)
    echo "QA"
;;

*/ZINOVA-PLATFORM-SANDBOX*)
    echo "SBX"
;;

*)
    echo "DEV"
;;

esac

}
