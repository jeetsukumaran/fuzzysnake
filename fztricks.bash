#! /bin/bash

# Source this file into your shell to enable enhancing your shell with
# 'FuzzySnake'.

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
## Shamelessly adapted from the *excellent* and *inspirational* 'fzf':
##
##      https://github.com/junegunn/fzf.git
##      Copyright (c) 2016 Junegunn Choi
##
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

# key bindings
##
## Shamelessly adapted from the *excellent* and *inspirational* 'fzf':
##
##      https://github.com/junegunn/fzf.git
##      Copyright (c) 2016 Junegunn Choi
if [ ! $FUZZYSNAKE_SUPPRESS_SHELL_KEYBINDINGS ]
then

    ## Type <CTRL-F> to invoke
    ## FuzzySnake
    bind '"\C-f": "fz\n"' 2>/dev/null

    if [[ ! -o vi ]]; then
        # Required to refresh the prompt after fzf
        bind '"\er": redraw-current-line'
        bind '"\e^": history-expand-line'

        # CTRL-R - Paste the selected command from history into the command line
        bind '"\C-r": " \C-e\C-u\C-y\ey\C-u`fzh`\e\C-e\er\e^"'

        # ALT-C - cd into the selected directory
        bind '"\ec": " \C-e\C-u`fzd`\e\C-e\er\C-m"'
    else
        # We'd usually use "\e" to enter vi-movement-mode so we can do our magic,
        # but this incurs a very noticeable delay of a half second or so,
        # because many other commands start with "\e".
        # Instead, we bind an unused key, "\C-x\C-a",
        # to also enter vi-movement-mode,
        # and then use that thereafter.
        # (We imagine that "\C-x\C-a" is relatively unlikely to be in use.)
        bind '"\C-x\C-a": vi-movement-mode'

        bind '"\C-x\C-e": shell-expand-line'
        bind '"\C-x\C-r": redraw-current-line'
        bind '"\C-x^": history-expand-line'

        # CTRL-R - Paste the selected command from history into the command line
        bind '"\C-r": "\C-x\C-addi`fzh`\C-x\C-e\C-x\C-r\C-x^\C-x\C-a$a"'
        bind -m vi-command '"\C-r": "i\C-r"'

        # ALT-C - cd into the selected directory
        bind '"\ec": "\C-x\C-addi`fzd`\C-x\C-e\C-x\C-r\C-m"'
        bind -m vi-command '"\ec": "ddi`fzd`\C-x\C-e\C-x\C-r\C-m"'
    fi
fi
