fuzzysnake
=========

A Fuzzy-finder for the terminal. A single-file pure-Python (2.7 and 3.4) file-only version of
`quickfind <https://github.com/Refefer/quickfind>`_ .  List, filter, and open
files for editing from your shell like CtrlP for Vim. The single-file
pure-Python design constraint ensures extreme deployment ease and portability:
simply copy the application ("`bin/fs`") to anywhere on your system PATH and
you are good to go!

Install
-------

As _fuzzysnake_ is a single-file program by design, you can simply copy the
file "`fs`" to anywhere on your system executable PATH, as, e.g.::

    sudo cp bin/fs /usr/local/bin

Alternatively, to install from Pypi::

    pip install fuzzysnake

Or to install from source, clone the
`repository <https://github.com/jeetsukumaran/fuzzysnake>`_.
and type::

    python setup.py install

in the directory.

'sudo' might be needed, depending on permissions.


To Use
------

After installation, a new executable is added to the path 'fs'.  To use, enter::

    fs

and start typing!  _fuzzysnake_ can be configured to match against file name and/or path
while selecting either files, directories, or both.  By default, it filters out files listed
in a tree's .gitignore.

Up and Down arrow keys selects which file to open.  Enter opens the current file with $EDITOR.
If -s FILENAME is specified, fuzzysnake writes the selected file to disk.

Tricks
------

- Add to your "`.bashrc`"::

    bind '"\C-f": "fs\n"'

  to add ctrl+f as a fs hotkey.

- Add to your "`.bashrc`"::

    function goto() {
        _OFILE=/tmp/fs.$$
        fs -d -s $_OFILE
        if [ -f $_OFILE ]; then
            cd `cat $_OFILE`
            rm $_OFILE
        fi
        unset _OFILE
    }

  to enable a new bash command, 'goto', for quickly cd-ing to a directory.

- Have a lot of files with similar names? Add the '-w' flag to allow multiple
  searchers.  '-w' splits queries by white space: a query for "hello world"
  would result in two filters: "hello" and "world", requiring a file to match
  both. This can be useful for specifying part of a filename and then the file
  extension.

Acknowledgements
----------------

_fuzzysnake_ is heavily-based on and lightly-modified from `quickfind
<https://github.com/Refefer/quickfind>`_, by Andrew Stanton.
