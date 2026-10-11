{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true;
    # dedicatedServer.openFirewall = true;
    # localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
      # ----- Gaming -----
      steam-rom-manager
      cemu
      rpcs3
      dolphin-emu
      prismlauncher
      protonplus
      sunshine
      moonlight-qt
      melonds
      # retroarch-full
      linuxKernel.packages.linux_zen.xone
      heroic
      ryubing
      xivlauncher

      # ----- Non-FOSS -----
      vesktop
      discord
  ];
}
