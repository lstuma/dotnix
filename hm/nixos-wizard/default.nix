{ pkgs }:
let
  pythonPackages = pkgs.python3Packages;
in
pythonPackages.buildPythonPackage rec {
  pname = "nixos-wizard";
  version = "0.1.0";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/13/01/1ab54acdafece3d9951a4bee4204ff1cca4c7a8ec02311af112e5b4242da/nixos_wizard-0.1.0.tar.gz";
    sha256 = "0sh0m1hgjrw55mx82hg52c65mlhp2y3nhpwacvfrpyvikgcgprk5";
  };
  doCheck = false;
}
