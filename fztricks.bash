#! /bin/bash

# Source this file into your shell to enable enhancing your shell with
# 'FuzzySnake'.

## Type <CTRL-F> to invoke
## FuzzySnake
bind '"\C-f": "fz\n"' 2>/dev/null

## `fzd`: select and go to a directory
function fzd() {
    # One-liner version: cd $(fz --stdout --single-selection -q -d || echo ".")
    local DESTDIR=$(fz --stdout --single-selection -d $@ || echo "")
    if [ -n "$DESTDIR" ]
    then
        echo $DESTDIR
        cd "$DESTDIR"
    fi
    unset DESTDIR
}

## `fzfd`: select file, and change to its directory
function fzfd() {
    local DIR
    local SELECTED=$(fz --stdout --single-selection $@ || echo "")
    if [ -n "$SELECTED" ]
    then
        DIR=$(dirname "$SELECTED" || echo "")
        if [ -n $DIR ]
        then
            cd $DIR
        fi
    fi
    unset DIR
    unset SELECTED
}

## `fzl`: list files
function fzl() {
    fz -L $@
}

## Select from history
## Shamelessly adapted from the *excellent* and *inspirational*:
## https://github.com/junegunn/fzf.git
function fzh() {
    shopt -u nocaseglob nocasematch
    local LINE
    LINE=$(HISTTIMEFORMAT= history | fz --stdout --output-relative-paths -) &&
    if [[ $- =~ H ]]; then
      sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$LINE"
    else
      sed 's/^ *\([0-9]*\)\** *//' <<< "$LINE"
    fi
}
if [[ ! -o vi ]]; then
    # CTRL-R - Paste the selected command from history into the command line
    bind '"\C-r": " \C-e\C-u\C-y\ey\C-u`fzh`\e\C-e\er\e^"'
else
    # CTRL-R - Paste the selected command from history into the command line
    bind '"\C-r": "\C-x\C-addi`fzh`\C-x\C-e\C-x\C-r\C-x^\C-x\C-a$a"'
    bind -m vi-command '"\C-r": "i\C-r"'
fi

## `fzw` ("w" for "work"): change to directory of selected and edit
function fzw() {
    local DIR
    local AGENT
    local SELECTED=$(fz --stdout --single-selection $@ || echo "")
    if [ -n "$FUZZYSNAKE_EDITOR" ]
    then
        AGENT="$FUZZYSNAKE_EDITOR"
    elif [ -n "$EDITOR" ]
    then
        AGENT="$FUZZYSNAKE_EDITOR"
    else
        AGENT="vi"
    fi
    if [ -n "$SELECTED" ]
    then
        DIR=$(dirname "$SELECTED" || echo "")
        if [ -n $DIR ]
        then
            cd $DIR
            $AGENT $SELECTED
        fi
    fi
    unset DIR
    unset FILENAME
    unset AGENT
    unset SELECTED
}

## `fzclip`: copy selected to clipboard
function fzclip() {
    if [ -z "$FUZZYSNAKE_CLIPBOARD_COPY_COMMAND" ]
    then
        echo "\$FUZZYSNAKE_CLIPBOARD_COPY_COMMAND not set"
        return
    fi
    $(fz --stdout $@ | $FUZZYSNAKE_CLIPBOARD_COPY_COMMAND)
}

# supporting functions
_get_abs_path() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}
