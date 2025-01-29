{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.tmux-nova
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.prefix-highlight
      tmuxPlugins.sensible
    ];
    extraConfig = ''
      # enable mouse click
      set -g mouse on

      # tab switching
      bind-key -r C-Right next-window
      bind-key -r C-Left previous-window
    '';
  };
}
