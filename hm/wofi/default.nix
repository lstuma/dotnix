{ lib, config, ... }:
{
  programs.rofi-wayland = {
    enable = true;
    style = ''
      ${(builtins.readFile ./style.css)}
    '';
  };
}
