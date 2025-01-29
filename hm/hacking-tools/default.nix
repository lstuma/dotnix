{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nmap
    gobuster
    dirb
    ffuf
    wfuzz
    wpscan
    whatweb
  ];
}
