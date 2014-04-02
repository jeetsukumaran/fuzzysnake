#! /bin/bash

# Source this file into your shell to enable enhancing your shell with
# 'FuzzySnake'.

## Type <CTRL-F> to invoke
## FuzzySnake
bind '"\C-f": "fz\n"'

## `fd` to select and go to a directory
function fd() {
    _OFILE=/tmp/fz.out
    if [ -f $_OFILE ]
    then
        rm $_OFILE
    fi
    fz -d -p $_OFILE
    if [ -f $_OFILE ]
    then
        targetdir=$(cat $_OFILE)
        # targetdir=$(printf '%q' "$targetdir") # escape special characters
        echo $(_get_abs_path "${targetdir}") # get absolute path
        cd "${targetdir}"
        rm $_OFILE
    fi
    unset _OFILE
}

# supporting functions
_get_abs_path() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}
