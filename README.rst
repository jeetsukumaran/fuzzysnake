FuzzySnake
==========

List, filter, and open files for editing from your shell, using dynamic
fuzzy-matching of patterns as you type them in. A "fuzzy" match is one in which
all the characters of the expression are found in the string in the same order
as they occur in the expression, but not necessarily consecutively. If you want
more control over the matching, you can use full-fledged regular expressions
instead of fuzzy-matching. The single-file pure-Python design constraint
ensures extreme deployment ease and portability: either use 'pip' to install
this program or simply copy the application ("`bin/fs`") to anywhere on your
system PATH and you are good to go!

This is single-file pure-Python (2.7 and 3.4) file-only modification and
extension of `quickfind <https://github.com/Refefer/quickfind>`_ (see below).

Installation
------------

Install the Script Directly
...........................

As `fuzzysnake` is a single-file program by design, you can simply grab the
latest version from its home and save it to somewhere on your system `$PATH`::

    $ sudo curl -ssl3 https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/bin/fs > /usr/local/bin/fs && chmod 0755 !#:3

or, if you do not have systems administration rights (but do have a "`~/bin`"
directory as this is in your `$PATH`)::

    $ curl -ssl3 https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/bin/fs > ~/bin/fs && chmod 0755 !#:3

Otherwise, if you have already downloaded the archive, you can simply copy the
file "`fs`" to anywhere on your system executable `$PATH`, as, e.g.::

    $ sudo cp bin/fs /usr/local/bin

or, as a personal installation::

    $ cp bin/fs ~/bin/ # assuming '~/bin' exists and is in $PATH

This is the optimum no-muss-no-fuss approach with maximum portability.

Install from the Python Package Index
.....................................

Alternatively, install from `PyPI <https://pypi.python.org/pypi>`_ by::

    $ pip install fuzzysnake

Install from Source
...................

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


You can also explicitly pass in directory paths to be searched::

    $ fs ~/projects ~/shared/data

After invoking `FuzzySnake`, all files found in the current (or the paths
otherwise specified in the command invocation) will be displayed in a list.
You can use the `<UP>` and `<DOWN>` arrow keys (or `<C-N>` and `<C-P>`) to
select an entry in the list, or you can type in a query to filter the list
dynamically as you type.  As you start typing characters, the list entries will
be filtered-out so that only the entries that fuzzily-match the growing
expression you are typing will be displayed. If you prefer, you can have your
expression be interpreted as a regular-expression instead of a fuzzy-one by
specifying the `-e` flag.

Once you have found a file that you want, you hit `<ENTER>`.

    * By default, `<ENTER>` opens the selected path for editing using the editor
      as set the environmental variable `$FUZZYSNAKE_EDITOR` or, if this is not
      defined, then `$EDITOR`.

    * If "`-p`" is specified then hitting `<ENTER>` will result in the
      selected filepath being written out to the standard output. This allows
      for actions such as::

          $ mv $(fs -p) ~/data
          $ cp *.txt $(fs -d -p)

    * Other actions are available: see 'fs --help' for details.

`FuzzySnake` can be configured to match against file name and/or path while
selecting either files, directories, or both. By default, it filters out files
listed in a directory tree's `.gitignore`. It can also match on the entire path
instead of just the tail or basename of the path, using the `-c` flag.

Stacking With `find`, `ack`, etc.
---------------------------------
If you invoke `FuzzySnake` with '-' as an argument, it will read entries from
the standard input pipe. This lets you use a external program, such as `find
<http://linux.about.com/od/commands/l/blcmdl1_find.htm>`_ or `ack
<http://beyondgrep.com/>`_, to make a first pass at file-discovery, and then
use `FuzzySnake` to dynamically select the final result with precision::

    $ find ~/projects -type f | fs -
    $ find ~/projects -name '*.py' | fs -
    $ ack -f | fs -

Demonstration
-------------

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

- To have couple the power of `ack` with `FuzzySnake`, add the following to your
  "`~/.bashrc`::

    alias ackfs='ack -f | fs -'

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

    * Full fuzzy-matching (i.e., "cat" will match not just "catfish"
      and "alleycat", but also, e.g, "charset" and "applecart", albeit at lower
      score).

    * Full regular expression matching also supported.

    * Python 3.x compatible.

    * Single-file implementation.

    * Uses "`curses`" for screen-input: more responsive to, e.g. "`ESC`" or
      "`Ctrl-C`" for cancellation.

    * Does *not* search for tags.

    * If "`fsnix`" is not installed, *much* slower.

