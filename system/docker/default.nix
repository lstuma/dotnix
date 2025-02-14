{ config, pkgs, ... }:
{
  virtualisation.docker.daemon = {
    enable = true;
    settings = {
      data-root = "/docker-root/";
    };
  };
  environment.systemPackages = with pkgs; [
    docker
  ];
}
