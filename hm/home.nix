{ lib, inputs, pkgs, ... }:
let
  nixos-wizard = import ./nixos-wizard { inherit pkgs; };
in
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.11"; # DO NOT CHANGE!!!!!!!!!

  home.keyboard.layout = "de";

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./stylix
    ./waybar
    ./hyprland
    ./wofi
    ./dunst
    ./yad
    ./kitty
    ./hyprpaper
    ./tmux
    ./hacking-tools
    ./zsh
    ./neofetch
    ./zed
    ./ferdium
    #./latex
    ./nixos-wizard
    ./dolphin
    ./nixvim
    ./intellij
    ./ollama
    #./ladybird
    #./qutebrowser
    ./floorp
    ./pferd
 ];
  stylix.targets = lib.mkForce {
    hyprland.enable = false;
    kitty.enable = false;
    waybar.enable = false;
    wofi.enable = false;
    gtk.enable = true;
  };

  gtk.enable = true;

  home.packages = with pkgs; [
    python3
    poetry
    pipx
    killall
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
    php
    neomutt
    tor-browser
    gdlauncher-carbon
  ];
}
