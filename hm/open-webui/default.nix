{ pkgs, ... }:
{
  home.packages = with pkgs; [
    open-webui
  ];
}
