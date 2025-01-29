{ lib, config, pkgs, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # enable swayfx
    package = null;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      startup = [
      ];
      bars = [];
      colors = {
        # default application window background
        background = "#282a36";
        # currently focused window
        focused = {
          background = "#282a36";
          border = "#bd93f9";
          childBorder = "#bd93f9";
          indicator = "#8be9fd";
          text = "#f8f8f2";
        };
        # focused window **of a container**, but not focues at the moment
        focusedInactive = {
          background = "#282a36";
          border = "#6272a4";
          childBorder = "#6272a4";
          indicator = "#8be9fd";
          text = "#f8f8f2";
        };
        # used to draw placeholder window contents (when restoring layouts). border and indicator are ignored
        placeholder = {
          background = "#282a36";
          border = "";
          childBorder = "";
          indicator = "";
          text = "#f8f8f2";
        };
        # unfocused windowi
        unfocused = {
          background = "#282a36";
          border = "#44475a";
          childBorder = "#44475a";
          indicator = "#8be9fd";
          text = "#f8f8f2";
        };
        # window with urgency hint activated
        urgent = {
          background = "#282a36";
          border = "#ff5555";
          childBorder = "#ff5555";
          indicator = "#8be9fd";
          text = "#f8f8f2";
        };
      };
      floating = {};
      focus = {
        followMouse = "yes";
        newWindow = "smart";
      };
      gaps = {
        bottom = 4;
        horizontal = 4;
        inner = 10;
        left = 4;
        outer = 4;
        right = 4;
        top = 4;
        vertical = 4;
  
        smartBorders = "off";
        smartGaps = false;
      };
      # see sway-input
      input = {
        "type:keyboard" = {
          xkb_layout = "de";
        }; 
      };
      keybindings = lib.mkOptionDefault {
          "${modifier}+q" = "kill";
          "${modifier}+Tab" = "workspace next";
          "${modifier}+Shift+Tab" = "workspace prev";
          "Mod1+Tab" = "exec ~/.config/sway/alttab next";
          "Mod1+Shift+Tab" = "exec ~/.config/sway/alttab prev";
      };
      menu = "rofi -show run";
    };
  };
  home.file."alttab-py-script" = {
    text = lib.mkForce (builtins.readFile ./alttab.py);
    target = ".config/sway/alttab";
    executable = true;
  };
}
