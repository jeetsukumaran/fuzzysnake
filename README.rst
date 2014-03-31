FuzzySnake
==========

A fuzzy-finder for the terminal. A single-file pure-Python (2.7 and 3.4)
file-only version of `quickfind <https://github.com/Refefer/quickfind>`_ .
List, filter, and open files for editing from your shell like CtrlP for Vim.
The single-file pure-Python design constraint ensures extreme deployment ease
and portability: simply copy the application ("`bin/fs`") to anywhere on your
system PATH and you are good to go!

Installation
------------

As `fuzzysnake` is a single-file program by design, you can simply copy the
file "`fs`" to anywhere on your system executable PATH, as, e.g.::

    $ sudo cp bin/fs /usr/local/bin

Alternatively, to install from Pypi::

    $ pip install fuzzysnake

Or to install from source, clone the
`repository <https://github.com/jeetsukumaran/fuzzysnake>`_.
and type::

    $ python setup.py install

in the directory.

Note that 'sudo' might be needed for the above operations, depending on
permissions.

To Use
------

After installation, a new executable is added to the path 'fs'.  To use, enter::

    $ fs

and start typing!  `FuzzySnake` can be configured to match against file name and/or path
while selecting either files, directories, or both. By default, it filters out files listed
in a tree's .gitignore.

Once you have selected a file, then:

    * `UP` and `DOWN` arrow keys selects which file to open.

    * By default, `ENTER` opens the current file for editing with
     `$FUZZYSNAKE_EDITOR` or, if this is not defined, then `$EDITOR.`

    * If "`-s FILENAME`" is specified, however, then `ENTER` will result in the
      selected file being written out to "`FILENAME`".

A demonstration of this program in usage can be found here:

    https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif

Enhancing Your Shell with FuzzySnake
------------------------------------

- To set `CTRL-F` as a hot-key to invoke FuzzySnake, add the following to your
  "`~/.bashrc`::

    bind '"\C-f": "fs\n"'


- To enable a new bash command, "`goto`", for quickly changing to a directory,
  add the following to your "`~/.bashrc`"::

    function goto() {
        _OFILE=/tmp/fs.$$
        fs -d -s $_OFILE
        if [ -f $_OFILE ]; then
            cd `cat $_OFILE`
            rm $_OFILE
        fi
        unset _OFILE
    }

- If you have lots of files with similar names, add the '-w' flag to allow
  multiple searchers. With this flag, multiple queries can be run simulatneous,
  with whitespace separating query terms: a query for "hello world" would
  result in two filters: "hello" and "world", requiring a file to match both.
  This can be useful for specifying part of a filename and then the file
  extension.

Acknowledgements
----------------

`FuzzySnake` is based on:

    `quickfind <https://github.com/Refefer/quickfind>`_ by Andrew Stanton.

Differences from `quickfind` are:

    * Pure-Python with no external dependencies (e.g., fsnix [though this will
      be used if available], python-ctags).

    * Does *actual* fuzzy-matching (i.e., "cat" will match not just "catfish"
      and "alleycat", but also, e.g, "charset" and "applecart", albeit at lower
      score).

    * Python 3.x compatible.

    * Single-file implementation.

    * Uses "`curses`" for screen-input: more responsive to, e.g. "`ESC`" or
      "`Ctrl-C`" for cancellation.

    * Does *not* search for tags.

    * If "`fsnix`" is not installed, *much* slower.

