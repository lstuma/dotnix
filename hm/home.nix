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
    ./zed
    ./ferdium
    ./latex
    ./nixos-wizard
  ];

  stylix.targets = lib.mkForce {
    hyprland.enable = false;
    kitty.enable = false;
    waybar.enable = false;
  };

  home.packages = with pkgs; [
    python3
    killall
    pferd
    tree
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
