{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  services.hyprpaper.settings = {
    wallpapers = [
      ", $HOME/.config/hypr/wallpaper.png"
    ];
  };
  file.home."hyprpaper-wallpaper" = {
    source = ./wallpaper.png;
    target = ".config/hypr/wallpaper.png";
  };
}
