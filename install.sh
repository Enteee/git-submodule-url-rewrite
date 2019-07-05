#!/usr/bin/env sh
set -euo pipefail
EXECUTABLE="git-submodule-url-rewrite"
REPO="Enteee/git-submodule-url-rewrite"
INSTALL="install -m 755 -o root ${EXECUTABLE}.dl ${EXECUTABLE}"

curl -s "https://api.github.com/repos/${REPO}/releases/latest" \
   | grep "browser_download_url" \
   | cut -d '"' -f 4 \
   | xargs -n1 curl -s -L --output "${EXECUTABLE}.dl"

trap 'rm "${EXECUTABLE}.dl"' EXIT

if [[ $(id -u) -ne 0 ]]; then
  sudo sh -c "${INSTALL}"
else
  eval "${INSTALL}"
fi
