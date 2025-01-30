{ lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ base16-schemes ];

  stylix = {
    enable = true;
    base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    image = ./wallpaper.png;
    cursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 12;
    };  
  };
}
