{ config, pkgs, lib, ... }:

{
  # Make system-wide libs always available
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    openssl
    libx11
    glib
  ];
  environment.sessionVariables = {
    LD_LIBRARY_PATH = lib.makeLibraryPath [
      pkgs.stdenv.cc.cc.lib
    ];
  };
}
