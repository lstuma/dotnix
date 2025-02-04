{ pkgs, ... }:
{
  stylix = {
    enable = true;
    polarity = "dark";
    iconTheme = {
      package = pkgs.papirus-icon-theme.override { color = "indigo"; };
      #dark = "Papirus-Dark"; # used
      #light = "Papirus-Light"; # unused
    };
  };
}
