{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    tmux
  ];

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.tmux-nova;
        extraConfig = ''
          # tmux-nova
          set -g @nova-nerdfonts true
          set -g @nova-nerdfonts-left 
          set -g @nova-nerdfonts-right 

          set -g @nova-segment-mode "#{?client_prefix,+,*}"
          set -g @nova-segment-mode-colors "#50fa7b #000000"

          set -g @nova-segment-whoami "#(whoami)@#h"
          set -g @nova-segment-whoami-colors "#50fa7b #282a36"

          set -g @nova-pane "#I#{?pane_in_mode, > #{pane_mode},} #W"

          set -g @nova-rows 0
          set -g @nova-segments-0-left "mode"
          set -g @nova-segments-0-right "whoami"
        '';
      }
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
