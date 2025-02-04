{ lib, config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    #package = pkgs.rofi-wayland;
    theme = ''
      ${(builtins.readFile ./style.css)}
    '';
  };
}
