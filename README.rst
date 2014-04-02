FuzzySnake
==========

List, filter, and open files for editing from your shell, using dynamic
fuzzy-matching of patterns as you type them in. A "fuzzy" match is one in which
all the characters of the expression are found in the string in the same order
as they occur in the expression, but not necessarily consecutively. If you want
more control over the matching, you can use full-fledged regular expressions
instead of fuzzy-matching. The single-file pure-Python design constraint
ensures extreme deployment ease and portability: either use 'pip' to install
this program or simply copy the application ("`bin/fz`") to anywhere on your
system PATH and you are good to go!

Installation
------------

As `fuzzysnake` is a single-file program by design, you can simply grab the
latest version from its home and save it to somewhere on your system `$PATH`::

    $ sudo curl -ssl3 https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/bin/fz > /usr/local/bin/fz && chmod 0755 !#:3

or, if you do not have systems administration rights (but do have a "`~/bin`"
directory as this is in your `$PATH`)::

    $ curl -ssl3 https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/bin/fz > ~/bin/fz && chmod 0755 !#:3

Otherwise, if you have already downloaded or cloned the project from its
`repository <https://github.com/jeetsukumaran/fuzzysnake>`_, you can enter the
project directory and type::

    $ python setup.py install

Note that 'sudo' might be needed for the above operation, depending on
permissions.

Of course, you simply copy the file "`fz`" to anywhere on your system
executable `$PATH`, for e.g.::

    $ cp bin/fz ~/bin/ # assuming '~/bin' exists and is in $PATH

or, if you have administrative privileges, as a system-wide installation::

    $ sudo cp bin/fz /usr/local/bin

Basic Usage
-----------

After installation, a new executable is added to the path 'fz'.  To use, enter::

    $ fz

You can also explicitly pass in directory paths to be searched::

    $ fz ~/projects ~/shared/data

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

          $ mv $(fz -p) ~/data
          $ cp *.txt $(fz -d -p)

    * Other actions are available: see 'fz --help' for details.

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

    $ find ~/projects -type f | fz -
    $ find ~/projects -name '*.py' | fz -
    $ ack -f | fz -

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

    bind '"\C-f": "fz\n"'

- To have couple the power of `ack` with `FuzzySnake`, add the following to your
  "`~/.bashrc`::

    alias ackfs='ack -f | fz -'

- If you have lots of files with similar names, add the '-w' flag to allow
  multiple searchers. With this flag, multiple queries can be run simulatneous,
  with whitespace separating query terms: a query for "hello world" would
  result in two filters: "hello" and "world", requiring a file to match both.
  This can be useful for specifying part of a filename and then the file
  extension.

Acknowledgements
----------------

`FuzzySnake` was inspired by:

    `quickfind <https://github.com/Refefer/quickfind>`_

by Andrew Stanton.
