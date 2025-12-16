# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  # ----- startup networking -----
  networking.wg-quick.interfaces.wg0.configFile = "/etc/wireguard/wg0.conf";
  # ------------------------------



  # -nvidia setup------------------------------------

  # Fix sleep freeze issue when logging back in
  environment.etc = {
    "modprobe.d/nvidia-preserve-vram.conf" = {
      text = ''
        options nvidia NVreg_PreserveVideoMemoryAllocations=1
        options nvidia NVreg_TemporaryFilePath=/var/tmp
      '';
    };
  };

  nixpkgs.config.allowUnfree = true;
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
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


  # -------------------------------------------------

  services.openssh = {
    enable = true;
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # ----- Custom Services -----
  services.envfs.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joermo = {
    isNormalUser = true;
    description = "Joseph";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vim
      neovim
      git
      ripgrep
      fzf
      zoxide
      lsd
      duf
      fd
      kitty
      zellij
      osu-lazer
      podman
      podman-tui
      element-desktop
      vscodium
      rsync
      curl
      wget
      hoppscotch
      dust
      rustc
      cargo
      rustup
      gping
      procs
      nodejs_24
      asdf-vm
      distrobox
      distrobox-tui
      boxbuddy
      spotify
      signal-desktop
      python313
      poetry
      isort
      pyenv
      gcc
      unzip
      wl-clipboard
      lazygit
      emacs
      ansible
      tree
      kustomize
      fluxcd
      libudev-zero


      # ----- Vim specifics -----
      #lua-language-server
      #prettierd
      #nodePackages_latest.prettier
      #stylua
      #isort
      #black
      #pylint
      #eslint_d
      #shellcheck
      #shfmt
      #markdownlint-cli2
      #github-markdown-toc-go
      #typescript-language-server
      #vscode-langservers-extracted
      #tailwindcss-language-server
      #svelte-language-server
      #lua-language-server
      #graphql-language-service-cli
      #emmet-language-server
      #pyright
      #ruff
      #marksman
      #rust-analyzer
      #yaml-language-server
      #beautysh



      # ----- Utilities -----
      input-remapper
      gearlever
      waydroid
      waydroid-helper
      localsend
      opentabletdriver
      openrgb
      clapper
      obs-studio
      affine
      nextcloud-client
      ppsspp-sdl-wayland
      calibre
      bitwarden-desktop
      bitwarden-cli
      xdg-utils
      btop
      gnumake
      kubectl
      k9s
      kubernetes-helm
      chromium
      tldx
      protonvpn-gui

      # ----- Gaming -----
      steam
      steam-rom-manager
      cemu
      rpcs3
      dolphin-emu
      duckstation
      prismlauncher
      protonplus
      sunshine
      moonlight-qt
      melonDS
      retroarch-full
      linuxKernel.packages.linux_zen.xone
      heroic
      ryubing
      xivlauncher

      # ----- Dev -----
      dbeaver-bin

      # ----- Non-FOSS -----
      vesktop
      #1password
      #1password-gui
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "mbedtls-2.28.10"
    "electron-35.7.5"
  ];


  # Install fonts here
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.joermo.shell = pkgs.zsh;
  #programs.ssh.startAgent = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    zsh
    wireguard-tools
    wireguard-ui
    #pkgs.home-manager

    pkgs.apacheHttpd
    openssl
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
