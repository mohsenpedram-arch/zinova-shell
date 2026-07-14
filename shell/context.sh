zinova_context ()
{
    local dir="$PWD"

    case "$dir" in

        */WORKSPACES/SHARED/ZEIS*)
            echo "ZEIS"
        ;;

        */WORKSPACES/SHARED/zinova-shell*)
            echo "SHELL"
        ;;

        */WORKSPACES/ZINOVA/zinova-platform*)
            echo "PLATFORM"
        ;;

        */WORKSPACES/ZINOVA/ZINOVA-CORE*)
            echo "CORE"
        ;;

        */WORKSPACES/ZINOVA/ZINOVA-PLATFORM-SANDBOX*)
            echo "PLATFORM"
        ;;

        */WORKSPACES/ZINOVA/ZINOVA-CORE-SANDBOX*)
            echo "CORE"
        ;;

        */WORKSPACES/ARZIN*)
            echo "ARZIN"
        ;;

        */WORKSPACES*)
            echo "LOCAL"
        ;;

        *)
            echo "LOCAL"
        ;;

    esac
}
