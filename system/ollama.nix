{ config, pkgs, ... }:
let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    overlays = [
      inputs.nix-comfyui.overlays.default
    ];
  };
in
{
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
    comfyui
  ];
}
