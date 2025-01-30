cyan="%{$fg_bold[cyan]%}"
pink="%{$fg_bold[red]%}"
NEWLINE=$'\n'

PS1='%{$cyan%}┌─(%{$pink%}%n %{$reset_color%}󱄅%{$pink%}%m%{$cyan%})-[%{$reset_color%}%~%{$cyan%}]'
PS1+=$NEWLINE
PS1+='└─%{$pink%}$%{$reset_color%} '

