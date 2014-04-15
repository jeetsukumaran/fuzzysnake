FuzzySnake
==========
A utility to find, list, filter, and act on files from your shell, using
dynamic fuzzy-matching of patterns as you type them in.

.. image:: https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif
   :height: 600px
   :alt: Demonstration of FuzzySnake in action.
   :target: https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif

.. contents::
    :local:

Introduction
------------

`FuzzySnake` is a filesystem navigation utility that lets you quickly locate
and act on files and directories using dynamic fuzzy matching. A "fuzzy" match
is one in which all the characters of the search expression are found in the
matched string in the same order as they occur in the search expression, but
not necessarily consecutively. If you want more control over the matching, you
can use full-fledged regular expressions instead of fuzzy-matching. Searches
can also be restricted to specific types of files, such as C++/C files, Python
files, Java files, and so on.

The single-file pure-Python design constraint ensures extreme deployment ease
and portability: simply copy the application (which can be found in the "`bin`"
subdirectory of the project: "`bin/fz`") to anywhere on your system PATH and
you are good to go!

Demonstration
-------------

You can see a demonstration this program being used here:

    https://raw.githubusercontent.com/jeetsukumaran/fuzzysnake/master/demo.gif

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

Of course, you can also simply copy the file "`fz`" to anywhere on your system
executable `$PATH`, for a personal installation::

    $ cp bin/fz ~/bin/ # assuming '~/bin' exists and is in $PATH

Or, if you have administrative privileges, as a system-wide installation::

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

Instead of opening the selected path in an editor, you can also execute a
custom command on it using the '`-c`'/'`--execute-command`' option, or open the
path in the type-specific system default application using the '`o`'/'`--open`'
option. These are discussed in more detail below.

If you decide that you do *not* want to follow through with any actions at all,
you can hit '`<ESC>`' or '`<CTRL-C>`' or '`<CTRL-G>`' at any time to cancel
`FuzzySnake` and return to the shell.

Setting the Default Editor
--------------------------

You can set the environmental variable '`$FUZZYSNAKE_EDITOR`' to specify the
application that `FuzzySnake` should use when opening the file. Typically, this
would be set in your shell configuration file so the setting would persist
across all sessions. For example, you could add one of the following to your
'`~/.bashrc`'::

    export FUZZYSNAKE_EDITOR='vim'
    export FUZZYSNAKE_EDITOR='sublime'
    export FUZZYSNAKE_EDITOR='gedit'

If the '`$FUZZYSNAKE_EDITOR`' environmental variable is not set, then the value
of '`$EDITOR`' is used instead. If this is not set, then '`vim`' is used, which
is what everybody should be using anyway.

Customizing the Match Mode
--------------------------
If the fuzzy matching is too fuzzy for you, you can use strict literal matching
by invoking `FuzzySnake` with the '`-l`' or '`--literal`' flag::

    $ fz -l

Alternatively, you can bring the full power of regular expressions to bear by
using the '`-e`' or '`--regexp`' flag::

    $ fz -e

In the middle of the search, while reviewing the list of candidates, you can
cycle through the different match modes by typing '`<CTRL-R`>' (similar to
toggling between fixed string and regular expression matching in `CtrlP
<https://github.com/kien/ctrlp.vim>`_ for `Vim <http://www.vim.org>`_). The
prompt will change to indicate the current match mode: '`?`' (fuzzy), '`=`'
(literal), or '`%`' (regular expression).

.. You can set a particular matching mode directly by:

.. - `<CTRL-F>` for fuzzy-matching mode,
.. - `<CTRL-E>` for regular-expression matching mode, and
.. - `<CTRL-L>` for literal-matching mode.

Matching on the Whole Path or Just the Basename
-----------------------------------------------

By default, `FuzzySnake` matches against just the basename of each filesystem
entry, i.e. just the last component of the complete path to the file or
directory.  If you want to match against the whole path, i.e. all the
components of the parent directory as well as the basename, then invoke
`FuzzySnake` with the '`-w`' flag::

    $ fz -w

When reviewing or filtering the list, you can switch back-and-forth between
matching the whole path or just the basename by using '<CTRL-D>' (similar to
toggling between full directory and filename path vs. filename only matching in
`CtrlP <https://github.com/kien/ctrlp.vim>`_ for `Vim <http://www.vim.org>`_).

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

Special support is available for some domains::

    $ fz --phylogenetics
    $ fz --nexus
    $ fz --newick

Restricting Searches by Glob Patterns
-------------------------------------

You can use the '`-n`' or '`--name-glob`' flag to restrict the list of entries
to those with basenames that match one or more `glob
<https://docs.python.org/3.4/library/fnmatch.html>`_ patterns.  You can use
this approach to create custom, on-the-fly target types to filter for::

    $ fz -n '*.log'
    $ fz -n '*.py' # same as 'fz --python'
    $ fz -n '*.log' -n '*.run.log'

For example, to select from a list of available tests to run in a Python project::

    $ fz -c 'python -m unittest' -n 'test_*.py'

Excluding Files and Directories
-------------------------------

Directories and files can be excluded from the initial results by supplying
matching regular-expression patterns via the '`-F`' and '`-D`' flags,
respectively::

    $ fz -F '\.*pyc'
    $ fz -D '.*build/'

Either of these may be optionally specified multiple times to match multiple
path patterns::

    $ fz -D '.*build/' -D '.*tmp$' -D '.*var' -F '\.*pyc$' -F 'output\d\+.txt'

Including Hidden Files and Directories
--------------------------------------
By default, `FuzzySnake` ignores hidden files and directories. To include
these, you need to invoke `FuzzySnake` with the '`-a`'/'`--include-hidden`'
option::

    $ fz -a

Note that version control directories ('`.git`', '`.hg`', '`.svn`', etc.) are
*always* excluded from all `FuzzySnake` searches.

Including Files and Directories Ignored by Git
----------------------------------------------
By default, `FuzzySnake` inspects any '`.gitignore`' and '`.git/info/exclude`'
files found and automatically applies the rules specified therein to pre-filter
out entries.  So, in most typical projects that have well-formulated
'`.gitignore`' or '`.git/info/exclude`, various build and project cruft paths
should automatically be filtered out without any effort from yourself. If you
do *not* want this behavior, and want to actually see paths ignored by
directives specified in the project's '`.gitignore`' or '`.git/info/exclude`'
files, then use the '`--include-gitignores`' flag to request that
`FuzzySnake` ignore these directives::

    $ fz --include-gitignores

Limiting the Search Depth
-------------------------
By default, `FuzzySnake` will drill down as far as it can go starting
from the directory in which it was invoked or the directory path(s) passed to
it as arguments. If you want to limit this, you can use the '`-r`' or
'`--recursion-limit`' option. This takes any integer >= 0 as an argument, and
specifies the maximum level of subdirectories that `FuzzySnake` should visit.
A value of '0' means that the search will be restricted only to the top-level
directory (i.e, the current directory or the directory paths explicitly passed
as an argument)::

    $ fz -r0
    $ fz -r0 ~/projects/archives

Higher numbers allow for deeper subdirectories to be visited::

    $ fz -r2 ~/projects/archives

Simultaneously and Independently Matching Multiple Terms ('`AND`'-ing)
----------------------------------------------------------------------
During the live search, you can specify multiple query terms, with terms
separated from each other by a '`;`' token character. A multiple-term query
will match each term simultaneously but separately. So, for example, if you
type in::

    foo;bar;baz

then names have to match "foo" *and* "bar" *and* "baz" independently (and in
any order) to be filtered through.

Thus, '`;`' can be seen as an '`AND`' operator.  The choice of '`;`' instead
of what might perhaps be the more obvious '`&`' is driven by the fact that this
is what `CtrlP <https://github.com/kien/ctrlp.vim>`_ for `Vim
<http://www.vim.org>`_ uses by default. You can specify an alternate token to
be used as term-delimiter by using the '`-t`' or '`--term-separator`' flag when
invoking `FuzzySnake`. So, for example, to use '`&`', you could type::

    $ fz -t '&'

In which case, a query for a filename that fuzzily matches "foo" and "bar" and
"baz" will be entered as::

    foo&bar&baz

Executing Custom Commands on the Selected File or Directory
-----------------------------------------------------------
Instead of editing the selected file (or directory, if the
'`-d`'/'`--directory-paths`' option is used) in your favorite text editor, you
can choose to have a custom command to be executed on it by passing the
'`-c`'/'`--execute-command`' option to `FuzzySnake`::

    $ fz -c 'wc -l'
    $ fz -c 'git add'
    $ fz -c 'python'
    $ fz -c 'open -a "Preview"'

As another example, the following alias in your '`~/.bashrc`' allows you to use
`FuzzySnake` to search for all tree files and open them in FigTree on OSX
platforms::

    alias fz-figtree='fz -n '\''*.tre??'\'' -n '\''*.nex'\'' -c '\''open -a "FigTree v1.3.1.app"'\'''

More complex command compositions can be achieved by using the token '`{}`' as
placeholders in the value you pass to the '`-c`'/'`--execute-command`' option.
When the actual command is composed to be executed, the '`{}`' tokens will be
replaced with the name of the file or directory that you have selected::

    $ fz -c 'mv {} ~/some/other/path'
    $ fz -c 'cp {} {}.bak'
    $ fz -c 'python {} --arg1 -arg2 posarg1 posarg2'

Alternatively, if you just want to open the selected path using the system
default application for the type of path, you can invoke `FuzzySnake` with the
'`-o`' option::

    $ fz -o

You can also use the '`-p`'/'`--print`' option to have `FuzzySnake` write out
the name of the selected path to a specified file, or the '`-1`'/'`--stdout`'
flag to write out the name of the selected path to the standard output. This is
typically used when using `FuzzySnake` as part of a custom shell function or
command, such as the "fuzzily-change-directory" command described below and
given in the example '`fztricks.sh`" file.

Selecting Multiple File and Directory Names
-------------------------------------------
If you type `<TAB>` on any entry, the item will be marked for selection, while
typing `<TAB>` on a marked entry toggles the marking off. Thus, you can use
`<TAB>` to mark one or more entries for `FuzzySnake` to act on when you finally
hit `<ENTER>`, whether this action is to open the selected entries in an editor
for editing (default), print the names of the selected entries to the standard
output ('`--standard-output`'), execute an arbitrary command on the entries
('`-c`'/'`--execute-command`') and so on. Note that typing `<ENTER>` on an
unmarked entry automatically adds that entry to the list of selected entries,
and the specified action will be invoked on it as well as the other selected
entries. If you type `<CTRL-U>` at any time, all marked items will be unmarked,
while, conversely, `<CTRL-A>` will mark all the entries. If you want to force
`FuzzySnake` to only accept a single selection, you can invoke `FuzzySnake` in
single-selection mode by using the '`-s`' or '`--single-selection`' flag::

    $ fz -s

Opening All the Files and Directories Found
-------------------------------------------
Instead of entering a dynamic fuzzy (or some other type of) matching session,
if you invoke `FuzzySnake` with a '`-L`'/'`--list`' flag, the names of all the
files or directories found will be printed to the standard output. This allows
you to leverage the file-finding abilities of `FuzzySnake` to generate a list
of names that you can pass to other programs as arguments. The advantage over
'`find`' is the pre-filtering that `FuzzySnake` does by default, ignoring
hidden files and directories, version control directories, as well as files
ignored by Git as specified by directives in various '`.gitignore`' and
'`.git/info/exclude`' files::

    $ vim $(fz -L)

Even more useful is leveraging the file-type specific filtering power of
`FuzzySnake` to quickly open a set of files for editing::

    $ vim $(fz -L --python)
    $ vim $(fz -L --python --sphinx)
    $ vim $(fz -L --cpp)
    $ vim $(fz -L --cpp --cmake)
    $ vim $(fz -L --tex --text)

Stacking With `find`, `ack`, etc.
---------------------------------
If you invoke `FuzzySnake` with '-' as an argument, it will read entries from
the standard input pipe. This lets you use an external program (such as `find
<http://linux.about.com/od/commands/l/blcmdl1_find.htm>`_, `ack
<http://beyondgrep.com/>`_, or `The Silver Searcher
<https://github.com/ggreer/the_silver_searcher>`_) to make a first pass at
file-discovery, and then use `FuzzySnake` to dynamically select the final
result with precision::

    $ find ~/projects -type f | fz -
    $ find ~/projects -name '*.py' | fz -
    $ ack -f | fz -
    $ ag -f | fz -

If you want to permanently couple the speed of these file discovery engines
with the dynamic interactivity of `FuzzySnake`, add the following to your
"`~/.bashrc`::

    alias fzfind='find . -type f | fz -'
    alias fzack='ack -f | fz -'
    alias fzag='ag -f | fz -'

Enhancing Your Shell with FuzzySnake
------------------------------------

The '`fztricks.sh`' file included with the `FuzzySnake` distribution includes
some useful enhancements for your shell. To use them, source the file into you
current session::

    $ . fztricks.sh

If you like them enough to keep them permanently, copy the contents of the file
'`fztricks.sh`' to your '`~/.bashrc`', or add a line in your '`~/.bashrc`' to
source the file.

These enhancements include:

- Setting `<CTRL-F>` as a shell hot-key to invoke FuzzySnake::

    bind '"\C-f": "fz\n"'

- A new command, `fd`, to change to a directory selected via `FuzzySnake`::

    function fd() {
        DESTDIR=$(fz --stdout --single-selection -d $@ || echo "")
        if [ -n "$DESTDIR" ]
        then
            echo $(_get_abs_path "${DESTDIR}")
            cd "$DESTDIR"
        fi
        unset DESTDIR
    }

 Note that this can also be done with a one-liner if you do not care to have
 the absolute path to the directory that you are changing to to be printed::

    cd $(fz --stdout --single-selection -d || echo ".")

Using `FuzzySnake` as the File Discovery Engine for CtrlP
---------------------------------------------------------

The following line your '`~/.vimrc`' will make `FuzzySnake` the default file
discovery engine when `CtrlP <https://github.com/kien/ctrlp.vim>`_ is invoked
in `Vim <http://www.vim.org>`_)::

    let g:ctrlp_user_command = "fz -L --no-progress-window %s"

This probably will not result in any faster file discovery as such, but it does
allow you to use the pre-filtering of `FuzzySnake` to exclude, for
example, files in your '`.gitignore`' etc.

Of course, this behavior can also be achieved using native CtrlP protocols::

    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

Perhaps more useful would be custom commands that more fully leverage the power
of `FuzzySnake`::

    function! s:_ctrlp_cpp_files()
        if exists("g:ctrlp_user_command")
            let l:old_user_command = g:ctrlp_user_command
        endif
        let g:ctrlp_user_command = 'fz -L --no-progress-window --cpp %s'
        :CtrlP
        if exists("l:old_user_command")
            let g:ctrlp_user_command = l:old_user_command
        else
            unlet g:ctrlp_user_command
        endif
    endfunction
    command! CtrlPCpp :call <SID>_ctrlp_cpp_files()

    function! s:_ctrlp_python_files()
        if exists("g:ctrlp_user_command")
            let l:old_user_command = g:ctrlp_user_command
        endif
        let g:ctrlp_user_command = 'fz -L --no-progress-window --python %s'
        :CtrlP
        if exists("l:old_user_command")
            let g:ctrlp_user_command = l:old_user_command
        else
            unlet g:ctrlp_user_command
        endif
    endfunction
    command! CtrlPPython :call <SID>_ctrlp_python_files()

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
