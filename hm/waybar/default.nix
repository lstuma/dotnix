{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
    sutils
    waybar-mpris
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "top";
        fixed-center = true;
        # debug
        reload_style_on_change = true;
        
        
        modules-left = [ "clock" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "tray" "mpris" "custom/conn" "pulseaudio" "custom/battery" "upower"];

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            default = "";              # "", 
            active = "";              # "", "", "󰊠", "❄"
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
          };
        };

        "custom/battery" = {
          exec = "/usr/bin/env bash $HOME/.config/waybar/scripts/battery.sh";
          interval = 5;
        };

        "custom/conn" = {
          exec = "/usr/bin/env bash $HOME/.config/waybar/scripts/wifi.sh loopback";
          interval = 3;
        };
      };
    };
    style = ''
      ${(builtins.readFile ./waybar.css)}
    '';
  };
  home.file."waybar-scripts" = {
    source = ./scripts;
    target = ".config/waybar/scripts";
    recursive = true;
    executable = true;
  };
}
