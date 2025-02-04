{ config, pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
  
  # Kernel parameters
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
  ];

  # Required NVIDIA modules for Wayland compatibility
  boot.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;


  # might help with üproblems when booting to text mode
  # boot.initrd.kernelModules = [ "nvidia" ];
  # boot.extraModulePackages = [
    # config.boot.kernelPackages.nvidia_x11
  # ];

  hardware.nvidia = {
    modesetting.enable = true;

    # disable (is experimental and will only break shit)
    # enable if graphical corruption and system crashes on suspend/resume (this is still an experimental
    # feature, but sometimes fixes this)
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    
    # don't use open source drivers (proprietary instead)
    open = true;

    # allow running nvidia-settings cmd
    nvidiaSettings = true;
    
    # might/should fix screen tearing issues
    forceFullCompositionPipeline = true;
  };

  # TODO: add multiple boot configurations for sync and offload
  hardware.nvidia.prime = {
    # EITHER use nvidia sync OR offload
    offload = {
      enable = false;
      enableOffloadCmd = false;
    };

    # reverseSync.enable = true;
    # allowExternalGpu = false;


    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:1";
  };
}
