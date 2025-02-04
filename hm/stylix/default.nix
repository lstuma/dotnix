{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    papirus-icon-theme
    breeze-icons
    adwaita-icon-theme
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    iconTheme = {
      package = pkgs.breeze-icons; # Ensure the package is installed
    };
  };
}
