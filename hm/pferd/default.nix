{ pkgs, ... }:
{
  home.packages = with pkgs; [
    master.pferd
  ];
}
