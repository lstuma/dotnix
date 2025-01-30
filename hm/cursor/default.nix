{ lib, config, pkgs, ... }:
{
  home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  wayland.windowManager.hyprland.exec-one = [
    "hyprctl setcursor phinger-cursors-light 24"
  ];
}
