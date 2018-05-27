#! /bin/bash

# Source this file into your shell to enable enhancing your shell with
# 'FuzzySnake'.

## Select from history
## Shamelessly adapted from the *excellent* and *inspirational* 'fzf':
##
##      https://github.com/junegunn/fzf.git
##      Copyright (c) 2016 Junegunn Choi
##

function fzh() {
    shopt -u nocaseglob nocasematch
    local LINE
    local SEDEX
    # LINE=$(HISTTIMEFORMAT= history | fz --stdout --output-relative-paths -) &&
    # if [[ $- =~ H ]]; then
    #   sed 's/^ *\([0-9]*\)\** .*/!\1/' <<< "$LINE"
    # else
    #   sed 's/^ *\([0-9]*\)\** *//' <<< "$LINE"
    # fi
    if [[ $- =~ H ]]; then
        SEDEX='s/^ *[0-9]*\** \(.*\)/\1/'
    else
        SEDEX='s/^ *\([0-9]*\)\** *//'
    fi
    # 1. Clear history format to get history in the form of '[number] [command]'
    # 2. Apply `sed` to strip leading number
    # 3. Apply `sed` to strip leading spaces
    # 4. Apply `sed` to strip trailing spaces
    # 5. Reverse list so that most recent commands are seen first ...
    # 6. Filter for duplicate lines, retaining order, keeping the first copy of each dupe (and because we reversed the list, this will the most recent command)
    # 7. Reverse list again that most recent commands are seen last (and thus appear at the top of the fuzzysnake list) ...
    # 8. Pass to fuzzysnake
    LINE=$(HISTTIMEFORMAT= history \
            | sed "$SEDEX" \
            | sed -e 's/^[ \t]*//' \
            | sed -e 's/[ \t]*$//' \
            | awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' \
            | awk '{ if (!h[$0]) { print $0; h[$0]=1 } }' \
            | fz --stdout --not-filesystem-paths -)
    echo $LINE
}

