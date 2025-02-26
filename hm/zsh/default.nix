{ lib, config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
    [[ ! -f ${~/.zsh_custom/scripts/back.sh;} ]] || source ${~/.zsh_custom/scripts/back.sh}
    '';
    autocd = false;
    shellAliases = {
      ll = "eza --color --icons -l";
      clearall = "printf '\\033[2J\\033[3J\\033[1;1H'";
      clear = "clearall";
      c = "/usr/bin/env clear"; # old clear command
    };
    oh-my-zsh = {
      enable = true;
      theme = "lstuma";
      custom = "$HOME/.zsh_custom";
    };
    history.size = 10000;
  };

  home.file."lstuma-zsh-theme" = {
    source = ./custom;
    target = ".zsh_custom/";
    recursive = true;
  };
}
