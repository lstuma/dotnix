{ lib, config, pkgs, ... }:
{
  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  wayland.windowManager.hyprland.exec-once = [
    "hyprctl setcursor phinger-cursors-light 24"
  ];
}
