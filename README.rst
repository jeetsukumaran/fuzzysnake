FuzzySnake
==========

List, filter, and open files for editing from your shell, using dynamic
fuzzy-matching of patterns as you type them in. A "fuzzy" match is one in which
all the characters of the expression are found in the string in the same order
as they occur in the expression, but not necessarily consecutively. If you want
more control over the matching, you can use full-fledged regular expressions
instead of fuzzy-matching. The single-file pure-Python design constraint
ensures extreme deployment ease and portability: simply copy the application
(which can be found in the "`bin`" subdirectory of the project: "`bin/fz`") to
anywhere on your system PATH and you are good to go!

Installation
------------

As `FuzzySnake` is a single-file program by design, you can simply grab the
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

To start using `FuzzySnake`, go to one of your favorite project directories,
and simply type::

    $ fz

Alternatively, you can can explicitly pass in one or more directory paths to be
searched::

    $ fz ~/projects ~/shared/data

After invoking `FuzzySnake`, all files found in the current (or the paths
otherwise specified in the command invocation) will be displayed in a list.
This list can be filtered by typing in characters in a fuzzily-matched query.
As you start typing characters, the list entries that do not match the growing
query expression will be filtered out.

Once you have the list down to manageable size, or whenever you see a file that
you want, ou can use the `<UP>` and `<DOWN>` arrow keys (or `<CTRL-N>` and
`<CTRL-P>`) to navigate to and select that entry.
Then you can hit `<ENTER>` to open it for editing in an editor of your choice,
as set the environmental variable `$FUZZYSNAKE_EDITOR` (if this is not defined,
then `$EDITOR` will be used instead).

Demonstration
-------------

A demonstration of this program can be found here:

    https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif

.. image:: https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif
   :height: 600px
   :alt: Demonstration of FuzzySnake in action.
   :target: https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif


Customizing the Match Mode
--------------------------
If the fuzzy matching is too fuzzy for you, you can use strict literal matching
by invoking `FuzzySnake` with the '`-l`' or '`--literal`' flag::

    $ fz -l

Alternatively, you can bring the full power of regular expressions to bear by
using the '`-e`' or '`--regexp`' flag::

    $ fz -e

You can switch matching modes in mid-search while reviewing the results list by
typing:

    - `<CTRL-F>` for fuzzy-matching mode,
    - `<CTRL-E>` for regular-expression matching mode, and
    - `<CTRL-L>` for literal-matching mode.

Matching on the Whole Path or Just the Basename
-----------------------------------------------

By default, `FuzzySnake` matches the entire path of each filesystem entry,
i.e., all the components of the parent directory as well as the file basename.
You can restrict the match to just the tail or basename of the path by invoking
`FuzzySnake` with the '`-b`' flag. When reviewing or filtering the list, you
can switch back-and-forth between matching the whole path or just the basename
by using '<CTRL-B>'.

Restricting Searches by File Type
---------------------------------

You can restrict the initial list of candidates offered for selection by file
type. For example, to search for only Python files::

    $ fz --python

Or only C++ files::

    $ fz --cpp

Multiple types of files can be specified simultaneously::

    $ fz --python --sphinx --markdown
    $ fz --cpp --make --autotools
    $ fz --cpp --cmake

Excluding Directories and Files
-------------------------------

Directories or files can be excluded from the initial results by supplying
matching regular-expression patterns via the '`-D`' and '`-F`' flags,
respectively::

    $ fz -D '.*build/'
    $ fz -F '\.*pyc'

Either of these may be optionally specified multiple times to match multiple
path patterns::

    $ fz -D '.*build/' -D '.*tmp$' -D '.*var' -F '\.*pyc$' -F 'output\d\+.txt'

Note that, by default, `FuzzySnake` inspects any '`.gitignore`' files found and
automatically applies the rules specified therein to pre-filter out entries.
So, in most typical projects that have well-formulated '`.gitignore`', various
build and project cruft files should automatically be filtered out without any
effort from yourself. If you do *not* want this behavior, and want to actually
see files ignored by '`.gitignore`' directives, then use the "`-i`" flag to
request that `FuzzySnake` ignore the '`.gitignore`'.

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

Enhancing Your Shell with FuzzySnake
------------------------------------

- To set `<CTRL-F>` as a hot-key to invoke FuzzySnake, add the following to your
  "`~/.bashrc`::

    bind '"\C-f": "fz\n"'

- To have couple the power of `ack` with `FuzzySnake`, add the following to your
  "`~/.bashrc`::

    alias fzack='ack -f | fz -'

- If you have lots of files with similar names, add the '-w' flag to allow
  multiple searchers. With this flag, multiple queries can be run simulatneous,
  with whitespace separating query terms: a query for "hello world" would
  result in two filters: "hello" and "world", requiring a file to match both.
  This can be useful for specifying part of a filename and then the file
  extension.

Acknowledgements
----------------

`FuzzySnake` is based on (and includes code derived from) '`quickfind
<https://github.com/Refefer/quickfind>`_' by Andrew Stanton, under version 2.0
of the Apache License.

License
-------

Copyright 2014 Jeet Sukumaran

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
