bold="%{fg_bold[white]}"
if [[ $terminfo[colors] -ge 256 ]]; then
  cyan="%{$fg_bold[cyan]%}"
  pink="%{$bold%}%{$FG[219]%}"
else
  cyan="%{$fg_bold[cyan]%}"
  pink="%{$fg_bold[red]%}"
fi
NEWLINE=$'\n'

PS1='%{$cyan%}┌─(%{$pink%}%n%{$reset_color%} 󱄅 %{$pink%}%m%{$cyan%})-[%{$reset_color%}%~%{$cyan%}]'
PS1+=$NEWLINE
PS1+='└─%{$pink%}$%{$reset_color%} '

