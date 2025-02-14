{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yad
  ];
}
