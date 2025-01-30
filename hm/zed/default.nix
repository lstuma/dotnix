{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zed
  ];
}
