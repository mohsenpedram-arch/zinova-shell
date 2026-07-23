#!/usr/bin/env bash
set -euo pipefail
source "$ARZIN_HOME/core/logger.sh"
source "$ARZIN_HOME/core/config.sh"

echo "================================="
echo " ARZIN PLATFORM DOCTOR"
echo " PROFILE: $ARZIN_PROFILE"
echo "================================="
echo

FAILED=0

check_command() {
    NAME=$1
    CMD=$2
    if command -v "$CMD" >/dev/null 2>&1; then
        ok "$NAME"
    else
        fail "$NAME"
        FAILED=1
    fi
}

check_command "Git" git
check_command "YQ (YAML Parser)" yq
check_command "Docker" docker
check_command "Docker Compose" docker
check_command "Java" java
check_command "Gradle" gradle
check_command "Kotlin" kotlinc
check_command "Python" python3
check_command "Rust" rustc
check_command "PostgreSQL Client" psql
check_command "Redis CLI" redis-cli
check_command "Kafka Client" kcat

if [[ "$ARZIN_PROFILE" == "integration" || "$ARZIN_PROFILE" == "production" ]]; then
    echo
    echo "[INFO] Checking Kubernetes tools (profile: $ARZIN_PROFILE)"
    check_command "kubectl" kubectl
    check_command "helm" helm
    check_command "k9s" k9s
fi

echo
if [ "$FAILED" -eq 0 ]; then
    echo "================================="
    echo " ARZIN STATUS: READY"
    echo "================================="
else
    echo "================================="
    echo " ARZIN STATUS: FAILED"
    echo "================================="
fi
exit $FAILED
