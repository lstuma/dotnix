{ lib, config, pkgs, ... }:
let
  pythonPackages = (python3.withPackages(ps: with ps; [ i3ipc pip ]));
  nixos-wizard-package =
  let
    pname = "nixos-wizard";
    version = "0.1.0";
  in
  pythonPackages.buildPythonPackage {
    inherit pname version;
    src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "7ad58437c6dc90904969697e40173f1da7a8f8324aa5b4576c8b71fe18e9b505";
    };
    doCheck = false;
  };
in
{
  pkgs.mkShell {
    packages = [
      nixos-wizard-package
    ];
  };
}
