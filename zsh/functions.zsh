# "cd /path/to/a/file" does "cd /path/to/a".
cd() {
  if [[ -f "$1" ]]; then
    builtin cd "${1:h}"
  elif [[ "$1" = "" ]]; then
    builtin cd
  else
    builtin cd "$1"
  fi
}

# Create a new directory and enter it.
mcd() {
  mkdir -p "$@" && cd "$@"
}

# Move to a directory and show its content.
cdl() {
  cd "$@" && ls;
}

# Create backup of a file.
bak() {
  cp "$1"{,.bak};
}

# Change working directory to the top-most Finder window location.
cdf() { # short for `cdfinder`
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Copy w/ progress.
cpprogress() {
  rsync -WavP --human-readable --progress $1 $2
}

# Determine size of a file or total size of a directory.
fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# Use Git’s colored diff when available.
hash git &>/dev/null
if [ $? -eq 0 ]; then
  diff() {
    git diff --no-index --color-words "$@"
  }
fi

# Create a data URL from a file>.
dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Image width.
iwidth() {
  echo $(sips -g pixelWidth $1 | grep -oE "[[:digit:]]{1,}$")
}

# Image height.
iheight() {
  echo $(sips -g pixelHeight $1 | grep -oE "[[:digit:]]{1,}$")
}

# Create a git.io short URL.
gitio() {
  if [ -z "${1}" -o -z "${2}" ]; then
    echo "Usage: \`gitio slug url\`"
    return 1
  fi
  curl -i http://git.io/ -F "url=${2}" -F "code=${1}"
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
#
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
  tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# Copied from oh-my-zsh's extract.plugin.zsh.
# Author Sorin Ionescu
extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
    echo
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) tar xvzf "$1" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) gunzip "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip|*.war|*.jar) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar x -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
      ;;
      (*)
        echo "extract: '$1' cannot be extracted" 1>&2
        success=1
      ;;
    esac

    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
}

# Creates an archive (*.tar.gz) from given directory.
mktar() {
  tar cvzf "${1%%/}.tar.gz"  "${1%%/}/";
}

# Create a ZIP archive of a file or folder.
mkzip() {
  zip -r "${1%%/}.zip" "$1";
}

# Repeat n times command.
repeatit() {
  local i max
  max=$1; shift;
  for ((i=1; i <= max ; i++)); do
    eval "$@";
  done
}

# Print confirmation.
# Usage:
#
# if ask "Kill process $pid <$pname> with signal $sig?"
#   then kill $sig $pid
# fi
ask() {
  echo -n "$@" '[y/n] ' ; read ans
  case "$ans" in
    y*|Y*) return 0 ;;
    *) return 1 ;;
  esac
}

# Open N windows stacked.
# vim -oN filea fileb filec
vo() {
  vim -o$# $*
}

# Recursively fix dir/file permissions on a given directory.
chfix() {
  if [ -d $1 ]; then
    find $1 -type d -exec chmod 755 {} \;
    find $1 -type f -exec chmod 644 {} \;
  else
    echo "$1 is not a directory."
  fi
}

# Find <dir> <file name regexp> <file contents regexp>.
fing() {
  find "$1" -name "$2" -exec grep -H "$3" "{}" \;
}

# Find a file under the current directory.
ff() {
  find . -name "$1";
}

# Find something in file.
finf() {
  find . -name "$1" -exec grep -H $2 {} \; ;
}

# Find something in all files.
finallf() {
  find . -type f -exec grep -H $1 {} \; ;
}

# Search files and remove them.
rmfiles() {
  find . -name "$1" -print0 | xargs -0 rm;
}

# Search directories and remove them.
rmdirs() {
  find . -name "$1" -print0 | xargs -0 rm -r;
}

# Syntax-highlight JSON strings or files.
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
json() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript
  else # pipe
    python -mjson.tool | pygmentize -l javascript
  fi
}
