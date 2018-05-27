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

## `fze` ("e" for "edit"): change to directory of selected and edit
function fze() {
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

