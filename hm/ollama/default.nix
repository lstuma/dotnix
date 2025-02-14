{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ollama
    #ollama-cuda
    #ollama-rocm
  ];
}
