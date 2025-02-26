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

__back_change_dir() {
  local dir="$(realpath $@)";
  local cwd="$(pwd)";
  builtin cd "$@";
  if [ $? -eq 0 ]; then
    __back_dirs_push "$cwd";
    __back_debug "PUSH 󰶻 $dir";
    __back_debug "CD 󰶻 $dir";
  fi
}
__back_back() {
  local last="$(__back_dirs_peek)";
  __back_dirs_pop;

  if [ -n "$last" ]; then
    builtin cd "$last";
    __back_debug "BACK 󰶻 $last";
    __back_debug "DIRS 󰶻 $DIRS";
  else
    echo "No more directories to go to";
  fi
}

alias cd="__back_change_dir";
alias back="__back_back";
