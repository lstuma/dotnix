{ lib, config, pkgs, ... }:
{
  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 16;
    gtk.enable = true;
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprctl setcursor phinger-cursors-light 12"
  ];
}
