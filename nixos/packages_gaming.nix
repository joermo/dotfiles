{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
      # ----- Gaming -----
      steam
      steam-rom-manager
      cemu
      rpcs3
      dolphin-emu
      prismlauncher
      protonplus
      sunshine
      moonlight-qt
      melonDS
      # retroarch-full
      linuxKernel.packages.linux_zen.xone
      heroic
      ryubing
      xivlauncher

      # ----- Non-FOSS -----
      vesktop
  ];
}
