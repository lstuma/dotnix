cyan="%F{cyan}"
yellow="%F{yellow}"
magenta="%F{magenta}"
pink="%F{red}"
green="%F{green}"
reset="$f"

PS1='%{$cyan%}┌─(%{$pink%}%n %{$reset%}on %{$pink%}%m%{$cyan%})-[%{$reset%}%~%{$cyan%}]\n└─%{$pink%}$'

