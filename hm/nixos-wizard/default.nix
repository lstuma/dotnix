{ pkgs }:
let
  pythonPackages = pkgs.python3Packages;
in
pythonPackages.buildPythonPackage rec {
  pname = "nixos-wizard";
  version = "0.1.0";
  src = pkgs.fetchPypi {
    inherit pname version;
    sha256 = "0sh0m1hgjrw55mx82hg52c65mlhp2y3nhpwacvfrpyvikgcgprk5";
  };
  doCheck = false;
}
