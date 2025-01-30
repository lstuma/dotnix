{ lib, inputs, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # DO NOT CHANGE!!!!!!!!!
  
  home.keyboard.layout = "de";

  imports = [ 
    ./waybar
    ./hyprland
    ./rofi
    ./dunst
    ./kitty
    ./hyprpaper
    ./tmux
    ./hacking-tools
    ./zsh
    ./neofetch
  ];

  stylix.targets = lib.mkForce {
    hyprland.enable = false;
    kitty.enable = false;
    waybar.enable = false;
  };

  home.packages = with pkgs; [
    python3
    killall
    signal-desktop
    obsidian
    git
    firefox
    kitty
    xterm
    rofi-wayland
    lunarvim
    eza
    keepassxc
  ];
}
