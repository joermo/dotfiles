{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nvidia_drivers.nix
      ./networking.nix
      ./desktop_environment.nix
      ./packages_productivity.nix
      ./packages_misc.nix
      ./packages_gaming.nix
      ./packages_vim.nix
    ];

  system.stateVersion = "25.05"; # READ THE DOCS BEFORE UPDATING THIS (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  nixpkgs.config.allowUnfree = true; # Allow unfree packages globally

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # -------------------------------------------------

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # ----- Custom Services -----
  services.envfs.enable = true;
  # ---------------------------

  services.printing.enable = true; # Enable CUPS to print documents.

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ----- User Account -----
  users.users.joermo = {
    isNormalUser = true;
    description = "Joseph";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };
  # ------------------------

  nixpkgs.config.permittedInsecurePackages = [
    "mbedtls-2.28.10"
    "electron-35.7.5"
  ];


  # ----- Fonts -----
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  # -----------------

  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.joermo.shell = pkgs.zsh;
}
