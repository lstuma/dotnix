{ lib, pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
  };
}
