#!/usr/bin/env zsh

# DIRS is an environment variable that holds the directory stack, stored as ; separated strings
export DIRS=""
# DEBUG_BACK is an environment variable that holds the debug mode

__back_dirs_pop() {
    # pop the last element from the array
    local dirs;
    IFS=';' read -r -A dirs <<< "$DIRS";
    unset 'dirs[-1]';
    DIRS="${(j:;:)dirs[@]::-1}";
}

__back_dirs_peek() {
    # peek the last element from the array and return it without popping
    local dirs;
    IFS=';' read -r -A dirs <<< "$DIRS";
    echo "${dirs[-1]}";
}

__back_dirs_push() {
    # push a directory to the stack only if it is not equal to the last element
    local dir="$1";
    local last="$(__back_dirs_peek)";
    if [ "$dir" = "$last" ]; then
        return;
    fi
    export DIRS="$DIRS;$dir";
}

__back_debug() {
    if [ -n "$DEBUG_BACK" ]; then
        echo "$1";
    fi
}

back_change_dir() {
  local dir="$(realpath $@)";
  local cwd="$(pwd)";
  if [ ! -d "$dir" ]; then
    echo "no such file or directory: $dir";
    return;
  fi
  builtin cd "$@";
  if [ $? -eq 0 ]; then
    __back_dirs_push "$cwd";
    __back_debug "PUSH 󰶻 $dir";
    __back_debug "CD 󰶻 $dir";
  fi
}
back_back() {
  if [ "$1" -eq "-l" ]; then
    # list the directories separated by \n
    echo "$DIRS" | sed 's/^;//';
    return;
  elif [[ "$1" =~ ^[0-9]+$ ]]; then
    # if $1 is a number, go back n times
    # first check if the number is greater than the number of directories (count the number of ;)
    local dircount="$(echo "$DIRS" | grep -o ";" | wc -l)";
    if [ "$1" -gt "$dircount" ]; then
      echo "no more directories to go to, only $dircount";
      return;
    fi
    local n="$1";
    for i in $(seq 1 $n); do
      back_back;
    done
    return;
  fi

  local last="$(__back_dirs_peek)";
  __back_dirs_pop;

  if [ -n "$last" ]; then
    builtin cd "$last";
    __back_debug "BACK 󰶻 $last";
    __back_debug "DIRS 󰶻 $DIRS";
  else
    echo "no more directories to go to";
  fi
}

alias cd="back_change_dir";
alias back="back_back";

zstyle ':completion:*:*:cd:*' file-sort size
