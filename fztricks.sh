#! /bin/bash

# Source this file into your shell to enable enhancing your shell with
# 'FuzzySnake'.

## Type <CTRL-F> to invoke
## FuzzySnake
bind '"\C-f": "fz\n"'

## `fzd`: select and go to a directory
function fzd() {
    # One-liner version: cd $(fz --stdout -d || echo ".")
    local DESTDIR=$(fz -q --stdout --single-selection -d $@ || echo "")
    if [ -n "$DESTDIR" ]
    then
        echo $(_get_abs_path "${DESTDIR}")
        cd "$DESTDIR"
    fi
    unset DESTDIR
}

## `fzl`: list files
function fzl() {
    fz -L $@
}

# supporting functions
_get_abs_path() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}
