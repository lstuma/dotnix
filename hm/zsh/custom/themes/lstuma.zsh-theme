cyan="%F{cyan}"
yellow="%F{yellow}"
magenta="%F{magenta}"
pink="%F{red}"
green="%F{green}"
NEWLINE=$'\n'

PS1='%{$cyan%}┌─(%{$pink%}%n %{$reset_color%}on %{$pink%}%m%{$cyan%})-[%{$reset_color%}%~%{$cyan%}]%{$newline%}└─%{$pink%}$%{$reset_color%}'

