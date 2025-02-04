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
    yiconTheme = {
      package = breeze-icons; # Ensure the package is installed
    };
  };
}
