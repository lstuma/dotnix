{ lib, config, pkgs, ... }:
{
  home.file."hypr-config" = {
    text = lib.mkForce (builtins.readFile ./hypr.conf);
    target = ".config/hypr/hypr.conf";
  };
}
