{ config, pkgs, lib, ... }:

{
  services.ollama = {
    enable = true;
    package = "cuda";
  };
}
