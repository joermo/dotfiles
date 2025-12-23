{ config, pkgs, lib, ... }:

{
  # Fix sleep freeze issue when logging back in
  environment.etc = {
    "modprobe.d/nvidia-preserve-vram.conf" = {
      text = ''
        options nvidia NVreg_PreserveVideoMemoryAllocations=1
        options nvidia NVreg_TemporaryFilePath=/var/tmp
      '';
    };
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable and unmask NVIDIA systemd services
  systemd.services."nvidia-suspend" = {
    enable = true;
    unitConfig.Mask = false;
  };

  systemd.services."nvidia-resume" = {
    enable = true;
    unitConfig.Mask = false;
  };

  systemd.services."nvidia-hibernate" = {
    enable = true;
    unitConfig.Mask = false;
  };
}
