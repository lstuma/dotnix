{ inputs, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # DO NOT CHANGE!!!!!!!!!
  
  home.keyboard.layout = "de";

  imports = [ 
    ./hypr
    ./sway
    ./waybar
    ./hyprland
    ./rofi
    ./dunst
    ./kitty
  ];

  home.packages = with pkgs; [
    python3
    signal-desktop
    obsidian
    git
    firefox
    kitty
    xterm
    rofi
    lunarvim
    eza

    nmap
    dirb
    gobuster
    ffuf
    wfuzz
    wpscan
    whatweb
  ];
}
