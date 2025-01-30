{ lib, config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    autocd = false;
    shellAliases = {
      ll = "eza --color --icons -l";
    };
    home = {
      sessionVariables = {
        PS1 = "%F{%(#.blue.green)}┌──\${debian_chroot:+($debian_chroot)─}\${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n on %m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]
└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset}";
      };
    };

    history.size = 10000;
    
  };
}
