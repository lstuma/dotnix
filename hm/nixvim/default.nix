{ lib, config, pkgs, ... }:
let
    nixvim = import (builtins.fetchGit {
        url = "https://github.com/nix-community/nixvim";
        # When using a different channel you can use `ref = "nixos-<version>"` to set it here
    });
in
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    
  };
}
