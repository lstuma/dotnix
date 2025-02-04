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
      name = "breeze"; # You can change this to "Papirus", "Adwaita", etc.
      package = pkgs.breeze-icons; # Ensure the package is installed
    };
  };
}
