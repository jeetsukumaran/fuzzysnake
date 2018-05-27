#! /bin/bash

# Source this file into your shell to enable enhancing your shell with
# 'FuzzySnake'.

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

source "$DIR/fztricks-bash/fztricks.paths.bash"
source "$DIR/fztricks-bash/fztricks.history.bash"
source "$DIR/fztricks-bash/fztricks.keybindings.bash"
