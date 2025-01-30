{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pferd
  ];
}
