{ pkgs, ... }:

{
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
      kustomize
      lazygit
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
      gearlever
      gnumake
      input-remapper
      k9s
      kubectl
      kubernetes-helm
      localsend
      nextcloud-client
      obs-studio
      openrgb
      opentabletdriver
      ppsspp-sdl-wayland
      protonvpn-gui
      tldx
      waydroid
      waydroid-helper
      xdg-utils

      # # ----- Non-FOSS -----
      # 1password
      # 1password-gui
  ];
}
