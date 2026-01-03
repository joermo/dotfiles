{ pkgs, ... }:

{
  # Enable docker
  virtualisation.docker = {
    enable = true;
  };

  # Enable 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "joermo" ];
  };

  environment.systemPackages = with pkgs; [
      #pkgs.home-manager
      ansible
      asdf-vm
      boxbuddy
      cargo
      certbot
      curl
      dig
      distrobox
      distrobox-tui
      duf
      dust
      element-desktop
      emacs
      fd
      fluxcd
      fzf
      gcc
      git
      gping
      hoppscotch
      isort
      kitty
      lazygit
      libreoffice
      libudev-zero
      lsd
      neovim
      nodejs_24
      openssl
      osu-lazer
      pkgs.apacheHttpd
      podman
      podman-tui
      poetry
      procs
      pyenv
      python313
      ripgrep
      rsync
      rustc
      rustup
      signal-desktop
      spotify
      tree
      unzip
      vim
      vscodium
      wget
      wireguard-tools
      wireguard-ui
      wl-clipboard
      zellij
      zoxide
      zsh


      # ----- Utilities -----
      affine
      bitwarden-cli
      bitwarden-desktop
      btop
      calibre
      chromium
      clapper
      dbeaver-bin
      envsubst
      gearlever
      gnumake
      input-remapper
      jq
      k9s
      kubeconform
      kubectl
      kubernetes-helm
      kustomize
      localsend
      nextcloud-client
      nushell
      obs-studio
      openrgb
      opentabletdriver
      opentofu
      ppsspp-sdl-wayland
      protonvpn-gui
      talosctl
      tldx
      waydroid
      waydroid-helper
      xdg-utils
      yq-go # official 'yq' cli

      # # ----- Non-FOSS -----
      # 1password
      # 1password-gui
  ];
}
