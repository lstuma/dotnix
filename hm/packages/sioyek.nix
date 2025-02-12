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
    url = "https://files.pythonhosted.org/packages/30/10/a44bdeaaa4169eb6448e18b29061d3cca8def8ae7ded99c70409acd603b1/nixos_wizard-0.1.1.tar.gz";
    sha256 = "0aeb4caf8429d63d75c9021f28b0f5f51286c5bf4fa6388887488d3dc5dea495";
  };
  doCheck = false;
  propagatedBuildInputs = dependencies;
}
