{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    (import ../packages/nixos-wizard.nix { inherit pkgs; })
  ];

  home.file."nixos-wizard-config" = {
    source = ./config.yaml;
    target = ".config/nixos-wizard/config.yaml";
  };
}
