{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
    sutils
    acpi
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
        margin = "5";
        # debug
        reload_style_on_change = true;


        modules-left = [ "custom/clock" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "tray" "custom/pferd" "custom/conn" "custom/volume" "custom/battery" "upower"];

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            default = "";              # "", "󱙝"
            active = "";              # "", "󰊠", "❄"
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
        "custom/pferd" = {
          exec = "/usr/bin/env bash $HOME/.config/waybar/scripts/pferd.sh waybar";
          return-type = "json";
          on-click = "/usr/bin/env bash $HOME/.config/waybar/scripts/pferd.sh run";
          exec-once = true;
        };
        "custom/ollama" = {
          exec = "/usr/bin/env bash $HOME/.config/waybar/scripts/ollama.sh";
          return-type = "json";
          on-click = "/usr/bin/env bash $HOME/.config/waybar/scripts/ollama.sh click";
          on-right-click = "/usr/bin/env bash $HOME/.config/waybar/scripts/ollama.sh right-click";
          exec-once = true;
        };
        "custom/clock" = {
          exec = "/usr/bin/env bash $HOME/.config/waybar/scripts/clock.sh";
          tooltip = true;
          return-type = "json";
          on-click = "/usr/bin/env bash $HOME/.config/waybar/scripts/clock.sh click";
          exec-once = true;
        };

        "custom/volume" = {
          exec = "/usr/bin/env bash $HOME/.config/waybar/scripts/volume.sh";
          on-click = "/usr/bin/env bash $HOME/.config/hypr/scripts/change-volume.sh mute";
          exec-once = true;
        };

        "custom/battery" = {
          exec = "/usr/bin/env bash $HOME/.config/waybar/scripts/battery.sh";
          return-type = "json";
          on-click = "/usr/bin/env bash $HOME/.config/waybar/scripts/battery.sh click";
          on-click-right = "/usr/bin/env bash $HOME/.config/waybar/scripts/battery.sh right-click";
          exec-once = true;
        };

        "custom/conn" = {
          exec = "/usr/bin/env bash $HOME/.config/waybar/scripts/wifi.sh";
          return-type = "json";
          exec-once = true;
          on-click = "/usr/bin/env bash $HOME/.config/waybar/scripts/wifi.sh click";
          on-click-right = "/usr/bin/env kitty -e nmtui";
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
