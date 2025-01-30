newline=$'\n'
reset="%{$reset_color%}"
bold="%{$fg_bold[white]%}"
cyan="%{$fg_bold[cyan]%}"

# 256 bit variable-colors
if [[ $terminfo[colors] -ge 256 ]]; then
  pink="%{$bold%}%{$FG[219]%}"
  blue="%{$bold%}%{$FG[33]%}"
else
  pink="%{$fg_bold[red]%}"
  blue="%{$fg_bold[blue]%}"
fi

# themeing
primary=$cyan
secondary=$blue
tertiary=$reset

# prompt
PS1='%{$primary%}┌─(%{$secondary%}%n%{$reset%} 󱄅 %{$secondary%}%m%{$primary%})-[%{$reset%}%~%{$primary%}]'
PS1+=$newline
PS1+='└─%{$secondary%}$%{$reset%} '

