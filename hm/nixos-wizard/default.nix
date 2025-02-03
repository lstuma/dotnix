{ pkgs }:
let
  pythonPackages = pkgs.python3Packages;
    dependencies = with pythonPackages; [
        rich
        pyyaml
    ];
in
pythonPackages.buildPythonPackage rec {
  pname = "nixos-wizard";
  version = "0.1.0";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/13/01/1ab54acdafece3d9951a4bee4204ff1cca4c7a8ec02311af112e5b4242da/nixos_wizard-0.1.0.tar.gz";
    sha256 = "7ad58437c6dc90904969697e40173f1da7a8f8324aa5b4576c8b71fe18e9b505";
  };
  doCheck = false;
  propagatedBuildInputs = dependencies;
}
