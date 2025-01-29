{ lib, config, pkgs, ... }:
{
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.blueman.enable = true;
  
  # allow audio
  hardware.pulseaudio.enable = true;
}
