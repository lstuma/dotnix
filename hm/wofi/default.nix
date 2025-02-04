{ lib, config, pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    style = ''
      ${(builtins.readFile ./style.css)}
    '';
  };
}
