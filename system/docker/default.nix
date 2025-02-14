{ config, pkgs, ... }:
{
  # lstuma has access to docker socket
  users.users.lstuma.extraGroups = [ "docker" ];

  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    daemon = {
      settings = {
        data-root = "/docker-root/";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    docker
    nvidia-docker
    nvidia-container-toolkit
    libnvidia-container
  ];
}
