#! /bin/bash

# Source this file into your shell to enable enhancing your shell with
# 'FuzzySnake'.

# Key bindings
if [ ! $FUZZYSNAKE_SUPPRESS_SHELL_KEYBINDINGS ]
then
    ##
    ## Shamelessly adapted from the *excellent* and *inspirational* 'fzf':
    ##
    ##      https://github.com/junegunn/fzf.git
    ##      Copyright (c) 2016 Junegunn Choi

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
