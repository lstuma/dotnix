{ lib, config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = false;
    shellAliases = {
      ll = "eza --color --icons -l";
    };
    oh-my-zsh = {
      enable = true;
      theme = "lstuma"; 
    };
    history.size = 10000;
  };

  home.file."lstuma-zsh-theme" = {
    source = ./lstuma.zsh-theme;
    target = "$ZSH/themes/lstuma.zsh-theme";
  };
}
