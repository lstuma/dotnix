{ lib, config, pkgs, ... }:
let
  pythonPackages = (python3.withPackages(ps: with ps; [ i3ipc pip ]));
  nixos-wizard-package = pkgs.python312Packages.buildPythonPackage rec {
    pname = "nixos-wizard";
    version = "0.1.0";
    src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "7ad58437c6dc90904969697e40173f1da7a8f8324aa5b4576c8b71fe18e9b505";
    };
    doCheck = false;
  };
  pythonEnv = pkgs.python312.buildEnv.override {
      extraLibs = [ nixos-wizard ];
  };
in
pkgs.mkShell {
  packages = [
    nixos-wizard-package
  ];
}
