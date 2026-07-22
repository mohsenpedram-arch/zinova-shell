#!/usr/bin/env bash
set -euo pipefail
source /etc/os-release
echo "================================="
echo " ARZIN OS DETECTOR"
echo "================================="
echo "OS_ID    : ${ID}"
echo "VERSION  : ${VERSION_ID}"
echo "CODENAME : ${VERSION_CODENAME:-unknown}"
echo
case "${ID}" in
  ubuntu)
    if [[ "${VERSION_ID}" == "24.04" ]] || [[ "${VERSION_ID}" == "22.04" ]]; then
      echo "[OK] Ubuntu ${VERSION_ID} detected"
      export ARZIN_OS="ubuntu"
      export ARZIN_VERSION="${VERSION_ID}"
    else
      echo "[ERROR] Unsupported Ubuntu version"
      exit 1
    fi
    ;;
  debian)
    if [[ "${VERSION_ID}" == "12" ]]; then
      echo "[OK] Debian 12 Bookworm detected"
      export ARZIN_OS="debian"
      export ARZIN_VERSION="12"
    else
      echo "[ERROR] Unsupported Debian version"
      exit 1
    fi
    ;;
  *)
    echo "[ERROR] Unsupported OS: ${ID}"
    exit 1
    ;;
esac
echo
echo "ARZIN OS PROFILE: ${ARZIN_OS}-${ARZIN_VERSION}"
echo "export ARZIN_OS=${ARZIN_OS}"
echo "export ARZIN_VERSION=${ARZIN_VERSION}"
