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
  version = "0.1.1";
  src = pkgs.fetchurl {
    url = "https://files.pythonhosted.org/packages/07/c4/05ba9ae45384c4b6d1ed43bb370b4d38d442ae6f461d8bd9669d6efe14d6/sioyek-0.31.11.tar.gz";
    sha256 = "2b3af02b6d4253cd2b4f64ad9ecdc8ba5cb6fbcdf0e8c5cf51d4cb92abbd4be3";
  };
  doCheck = false;
  propagatedBuildInputs = dependencies;
}
