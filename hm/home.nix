{ lib, inputs, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # DO NOT CHANGE!!!!!!!!!
  
  home.keyboard.layout = "de";

  imports = [ 
    ./sway
    ./waybar
    ./hyprland
    ./rofi
    ./dunst
    ./kitty
    ./hyprpaper
    ./tmux
    ./hacking-tools
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix.targets.hyprland.enable = lib.mkForce false;

  home.packages = with pkgs; [
    python3
    killall
    signal-desktop
    obsidian
    git
    firefox
    kitty
    xterm
    rofi
    lunarvim
    eza
    keepassxc
  ];
}
