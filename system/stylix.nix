{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ base16-schemes ];

  stylix.enable = true;
  
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  stylix.cursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 12;
  };
}
