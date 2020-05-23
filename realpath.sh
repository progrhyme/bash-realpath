# bash

# for debug
_REALPATH_TMP_DIR="${_REALPATH_TMP_DIR:-/tmp}"
_REALPATH_LOG_FILE="${_REALPATH_TMP_DIR}/bash-realpath.log"

_realpath_debug() {
  [[ -n "${_REALPATH_DEBUG:-}" ]] || return
  echo "[$(date +'%F %T')] $1" >> $_REALPATH_LOG_FILE
}

# Behaves like realpath
realpath() {
  local path="$1"
  _realpath_debug "realpath \"$path\""
  local parent name src
  local cwd="$(pwd)"

  if [[ "${path%/*}" = "$path" ]]; then
    if [[ -d "$path" ]];then
      echo "$(cd "$path"; pwd)"
    else
      echo "$cwd/$path"
    fi
    return
  fi

  while [[ -L "${path}" ]]; do
    cd "${path%/*}" || _realpath_debug "cd ${path%/*} failed!"
    _realpath_debug "pwd = \"$(pwd)\""
    name="${path##*/}"
    _realpath_debug "name = \"${name}\""
    src="$(readlink "$name")"
    _realpath_debug "src = \"${src}\""

    # Recursive link!!
    if [[ "$src" = "$name" ]]; then
      echo "Recursive link detected!!" >&2
      return 1
    fi

    path="$src"
  done

  _realpath_debug "path = \"${path}\""
  parent="$(cd "${path%/*}"; pwd)"
  echo "$parent/${path##*/}"
  cd "$cwd"
}
