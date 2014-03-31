FuzzySnake
==========

A fuzzy-finder for the terminal. A single-file pure-Python (2.7 and 3.4)
file-only version of `quickfind <https://github.com/Refefer/quickfind>`_ .
List, filter, and open files for editing from your shell, using dynamic
fuzzy-matching like CtrlP for Vim. A "fuzzy" match is one in which all the
characters of the expression are found in the string in the same order as they
occur in the expression, but not necessarily consecutively.  The single-file
pure-Python design constraint ensures extreme deployment ease and portability:
simply copy the application ("`bin/fs`") to anywhere on your system PATH and
you are good to go!

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

and start typing! Filesystem entries will be filtered-out so that only entries
that fuzzily-match the expression that you type will be listed. If you prefer,
you can have your expression be interpreted as a regular-expression instead of
a fuzzy-one by specifying the `-e` flag.

`FuzzySnake` can be configured to match against file name and/or path while
selecting either files, directories, or both. By default, it filters out files
listed in a directory tree's `.gitignore`. It can also match on the entire path
instead of just the tail or basename of the path, using the `-c` flag.

Once you have filtered down the list of candidates, you can use the `UP` or
`DOWN` arrow keys to select a file path.

    * By default, `ENTER` opens the selected path for editing using the editor
      as set the environmental variable `$FUZZYSNAKE_EDITOR` or, if this is not
      defined, then `$EDITOR`.

    * If "`-p`" is specified then hitting `ENTER` will result in the
      selected filepath being written out to the standard output. This allows
      for actions such as::

          $ mv $(fs -p) ~/data
          $ cp *.txt $(fs -d -p)

    * Other actions are available: see 'fs --help' for details.

A demonstration of this program in usage can be found here:

    https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif

.. image:: https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif
   :height: 600px
   :alt: Demonstration of FuzzySnake in action.
   :target: https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif

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

Major differences from `quickfind` are:

    * Pure-Python with no external dependencies (e.g., fsnix [though this will
      be used if available], python-ctags).

    * Does *actual* fuzzy-matching (i.e., "cat" will match not just "catfish"
      and "alleycat", but also, e.g, "charset" and "applecart", albeit at lower
      score).

    * Python 3.x compatible.

    * Single-file implementation.

    * Supports regular-expression searching as an option instead of fuzzy
      normal-text searching.

    * Uses "`curses`" for screen-input: more responsive to, e.g. "`ESC`" or
      "`Ctrl-C`" for cancellation.

    * Does *not* search for tags.

    * If "`fsnix`" is not installed, *much* slower.

