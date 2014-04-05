#! /bin/bash

# Source this file into your shell to enable enhancing your shell with
# 'FuzzySnake'.

## Type <CTRL-F> to invoke
## FuzzySnake
bind '"\C-f": "fz\n"'

## `fd`: select and go to a directory
function fd() {
    # One-liner version: cd $(fz --stdout -d || echo ".")
    DESTDIR=$(fz --stdout -d)
    if [ -n "$DESTDIR" ]
    then
        echo $(_get_abs_path "${DESTDIR}")
        cd "$DESTDIR"
    fi
    unset DESTDIR
}

# supporting functions
_get_abs_path() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}
