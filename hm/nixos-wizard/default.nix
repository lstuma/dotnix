{ pkgs }:
let
  pythonPackages = pkgs.python3Packages;
in
pythonPackages.buildPythonPackage {
  pname = "nixos-wizard";
  version = "0.1.0";
  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "7ad58437c6dc90904969697e40173f1da7a8f8324aa5b4576c8b71fe18e9b505";
  };
  doCheck = false;
}
