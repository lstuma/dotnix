{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "$HOME/.config/hypr/wallpaper.png"
      ];

      wallpaper = [
        ", $HOME/.config/hypr/wallpaper.png"
      ];
    };
  };

  home.file."hyprpaper-wallpaper" = {
    source = ./wallpaper.png;
    target = ".config/hypr/wallpaper.png";
  };
}
