{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    waybar
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
        modules-right = [ "tray" "mpris" "pulseaudio" "bluetooth" "battery" "upower"];

        "hyprland/workspaces" = {
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            default = "";              # "", 
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

        "battery" =  {
          format = "{capacity}% {icon}";
          tooltip-format = "{time} {icon}";
          format-charging = "󱐋 {capacity}%";
          format-icons = [ "" ];
        };
      };
    };
    style = ''
      ${(builtins.readFile ./waybar.css)}
    '';
  };
}
