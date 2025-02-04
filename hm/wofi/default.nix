{ lib, config, pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    #package = pkgs.rofi-wayland;
    style = ''
      ${(builtins.readFile ./style.css)}
    '';
  };
}
