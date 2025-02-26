{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    pamixer
    playerctl
    libnotify
    brightnessctl
    pavucontrol
    hyprlock
    hyprshot
    wdisplays
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # fix x-apps blurry/low-res
    extraConfig = ''
      xwayland {
        force_zero_scaling = true
      }
      env = QT_QPA_PLATFORM,wayland
      env = QT_QPA_PLATFORMTHEME,qt5ct
    '';
    settings = {
      input.kb_layout = "de";
      exec-once = [
        "dunst"
        "waybar"
        "hyprpaper"
        "hyprctl setcursor phinger-cursor-light 16"
      ];
      "$mod" = "SUPER";
      bind = [
        # open terminal
        "$mod, RETURN, exec, kitty"
        # rofi launcher
        "$mod, D, exec, pkill wofi || wofi --show drun --allow-images --no-actions"
        # screenshot
        "$mod SHIFT, J, exec, hyprshot -m region --clipboard-only"
        # killactive
        "$mod, Q, killactive"
        # floating
        "$mod, F, togglefloating"
        # fullscreen
        "$mod, SPACE, fullscreen, 0"
        # lockscreen
        "$mod, L, exec, pidof hyprlock || hyprlock -q"
        # alt-tab window control
        "ALT, tab, cyclenext"
        "ALT, tab, bringactivetotop"
        "ALT SHIFT, tab, cyclenext, prev"
        "ALT SHIFT, tab, bringactivetotop"
        # move window
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        # super+tab workspace movement
        "$mod, tab, workspace, m+1"
        "$mod SHIFT, tab, workspace, m-1"
        # move to workspace with super+num
        "$mod, code:10, workspace, 1"
        "$mod, code:11, workspace, 2"
        "$mod, code:12, workspace, 3"
        "$mod, code:13, workspace, 4"
        "$mod, code:14, workspace, 5"
        "$mod, code:15, workspace, 6"
        "$mod, code:16, workspace, 7"
        "$mod, code:17, workspace, 8"
        "$mod, code:18, workspace, 9"
        "$mod, code:19, workspace, 10"
        # move window to workspace
        "$mod SHIFT, code:10, movetoworkspace, 1"
        "$mod SHIFT, code:11, movetoworkspace, 2"
        "$mod SHIFT, code:12, movetoworkspace, 3"
        "$mod SHIFT, code:13, movetoworkspace, 4"
        "$mod SHIFT, code:14, movetoworkspace, 5"
        "$mod SHIFT, code:15, movetoworkspace, 6"
        "$mod SHIFT, code:16, movetoworkspace, 7"
        "$mod SHIFT, code:17, movetoworkspace, 8"
        "$mod SHIFT, code:18, movetoworkspace, 9"
        "$mod SHIFT, code:19, movetoworkspace, 10"
        # scroll through workspaces
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        # move window
        "$mod CTRL, left, movewindow, l"
        "$mod CTRL, right, movewindow, r"
        "$mod CTRL, up, movewindow, u"
        "$mod CTRL, down, movewindow, d"
      ];
      bindl = [
        # audio control
        ", xf86audioraisevolume, exec, /usr/bin/env bash $HOME/.config/hypr/scripts/change-volume.sh up 5"
        ", xf86audiolowervolume, exec, /usr/bin/env bash $HOME/.config/hypr/scripts/change-volume.sh down 5"
        ", xf86audiomute, exec, /usr/bin/env bash $HOME/.config/hypr/scripts/change-volume.sh mute"
        # media control
        ", xf86AudioPlayPause, exec, playcerctl play-pause"
        ", xf86AudioNext, exec, playerctl next"
        ", xf86AudioPrev, exec, playerctl previous"
        # brightness control
        ", xf86MonBrightnessDown, exec, /usr/bin/env bash $HOME/.config/hypr/scripts/change-brightness.sh down 5"
        ", xf86MonBrightnessUp, exec, /usr/bin/env bash $HOME/.config/hypr/scripts/change-brightness.sh up 5"
      ];
      binde = [
        # resize windows
        "$mod SHIFT, left, resizeactive,-50 0"
        "$mod SHIFT, right, resizeactive,50 0"
        "$mod SHIFT, up, resizeactive,0 -50"
        "$mod SHIFT, down, resizeactive,0 50"
      ];
      bindm = [
        # resize wirndow with dragging
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      general = {
        "gaps_in" = 4;
        "gaps_out" = 6;
        "col.active_border" = "rgb(44475a) rgb(bd93f9) 90deg";
        "col.inactive_border" = "rgba(44475aaa)";
        "col.nogroup_border" = "rgba(282a36dd)";
        "col.nogroup_border_active" = "rgb(bd93f9) rgb(44475a) 90deg";
        "no_border_on_floating" = false;
        "border_size" = 2;
      };
      decoration = {
        rounding = 5;
      };
      group = {
        groupbar = {
          "col.active" = "rgb(bd93f9) rgb(44475a) 90deg";
          "col.inactive" = "rgba(282a36dd)";
        };
      };
    };
  };

  home.file."hyprland-scripts-dir" = {
    source = ./scripts;
    target = ".config/hypr/scripts";
    recursive = true;
    executable = true;
  };
}
