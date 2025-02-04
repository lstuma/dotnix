{ pkgs, ... }:
{
  stylix = {
    enable = true;
    iconTheme = {
      name = "Papirus";  # Replace with your preferred icon theme
      package = pkgs.papirus-icon-theme;  # Ensure the icon theme package is installed
    };
  };
}
