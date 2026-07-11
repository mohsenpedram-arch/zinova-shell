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
    echo "CORE"
;;

*/ZINOVA-CORE/ZINOVA-CORE*)
    echo "CORE"
;;

*/ZINOVA-CORE)
    echo "WORKSPACE"
;;

*/ZINOVA-CORE/zinova-shell*)
    echo "SHELL"
;;

*/ARZIN-CORE*)
    echo "ARZIN"
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
