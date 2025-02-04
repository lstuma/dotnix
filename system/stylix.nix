{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    base16-schemes
    breeze-icons
    papirus-icon-theme
    adwaita-icon-theme
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    image = ./wallpaper.png;
    cursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 16;
    };
  };
}
