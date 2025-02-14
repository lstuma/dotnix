{ inputs, config, pkgs, ... }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.nix-comfyui.overlays.default
    ];
  };
in
{
  # open-webui docker
  #pkgs.dockerTools.pullImage{
  #  imageName = "ghcr.io/open-webui/open-webui:main";
  #  finalImageTag = "2.0";
  #  imageDigest = "sha256:632268d5fd9ca87169c65353db99be8b4e2eb41833b626e09688f484222e860f";
  #  sha256 = "1x00ks05cz89k3wc460i03iyyjr7wlr28krk7znavfy2qx5a0hfd";
  #};


  services.ollama = {
    # package = pkgs.unstable.ollama; # If you want to use the unstable channel package for example
    enable = true;
    acceleration = "cuda"; # Or "rocm"
    # environmentVariables = { # I haven't been able to get this to work myself yet, but I'm sharing it for the sake of completeness
      # HOME = "/home/ollama";
      # OLLAMA_MODELS = "/home/ollama/models";
      # OLLAMA_HOST = "0.0.0.0:11434"; # Make Ollama accesible outside of localhost
      # OLLAMA_ORIGINS = "http://localhost:8080,http://192.168.0.10:*"; # Allow access, otherwise Ollama returns 403 forbidden due to CORS
    #};
  };

  services.open-webui = {
    package = pkgs.open-webui; # pkgs must be from stable, for example nixos-24.11
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
    };
  };
  environment.systemPackages = with pkgs; [
    comfyuiPackages.comfyui
  ];
}
