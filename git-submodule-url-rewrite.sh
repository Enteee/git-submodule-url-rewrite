#!/usr/bin/env sh
set -euo pipefail

export GIT_SUBMODULE_CMD="git submodule --quiet"
export UPDATE_CMD="git submodule update --init"

usage() {
  cat <<EOF
usage: git submodule-url-rewrite [-h|--help] [-r|--recursive] sed-script

Rewrites all submodule urls using the given sed-script

options:
  -h|--help       Print this help
  -v|--verbose    Make this script verbose
  -r|--recursive  Also rewrite submodules of submodules
  -u|--update     Run '${UPDATE_CMD}' after url rewrite
EOF
}

export VERBOSE=false
export RECURSIVE=""
export UPDATE=false
export SED_ARGS=""

while true; do
  case "${1:-""}" in

    -h|--help)
      usage && exit 0
    ;;

    "")
      usage
      exit 1
    ;;

    -v|--verbose)
      VERBOSE=true && shift
      GIT_SUBMODULE_CMD="git submodule"
    ;;

    -r|--recursive)
      RECURSIVE="--recursive" && shift
    ;;

    -u|--update)
      UPDATE=true && shift
    ;;

    *)
      SED_ARGS="${*}"
      break
    ;;

  esac
done

sm_url_rewrite(){
  set -euo pipefail
  if [ "${VERBOSE}" = true ]; then set -x; fi

  local gitmodules="${toplevel}/.gitmodules"
  local old_url="$(git config --file="${gitmodules}" "submodule.${name}.url")"
  local new_url="$(echo "${old_url}" | sed ${SED_ARGS})"

  git config --file="${gitmodules}" "submodule.${name}.url" "${new_url}"
  ${GIT_SUBMODULE_CMD} sync

  if [ "${UPDATE}" = true ]; then
    ${UPDATE_CMD}
  fi
}
export -f sm_url_rewrite

if [ "${VERBOSE}" = true ]; then set -x; fi

${GIT_SUBMODULE_CMD} foreach ${RECURSIVE} sm_url_rewrite
