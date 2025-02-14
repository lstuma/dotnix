{ config, pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    daemon = {
      settings = {
        data-root = "/docker-root/";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    docker
    nvidia-container-toolkit
  ];
}
