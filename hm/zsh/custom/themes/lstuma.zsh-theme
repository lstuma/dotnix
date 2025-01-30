newline=$'\n'
reset="%{$reset_color%}"
bold="%{$fg_bold[white]%}"
cyan="%{$fg_bold[cyan]%}"

# 256 bit variable-colors
if [[ $terminfo[colors] -ge 256 ]]; then
  pink="%{$bold%}%{$FG[219]%}"
  blue="%{$bold%}%{$FG[033]%}"
else
  pink="%{$fg_bold[red]%}"
  blue="%{$fg_bold[blue]%}"
fi

# themeing
primary=$cyan
secondary=$blue
tertiary=$cyan

# prompt
PS1='%{$primary%}┌─(%{$secondary%}%n%{$tertiary%} 󱄅 %{$secondary%}%m%{$primary%})-[%{$reset%}%~%{$primary%}]'
PS1+=$newline
PS1+='└─%{$secondary%}$%{$reset%} '

