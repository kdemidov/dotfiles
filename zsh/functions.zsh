# `cd /path/to/a/file` does `cd /path/to/a`
function cd() {
  if [[ -f "$1" ]]; then
    builtin cd "${1:h}"
  elif [[ "$1" = "" ]]; then
    builtin cd
  else
    builtin cd "$1"
  fi
}
