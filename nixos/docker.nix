{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      dns = [ "10.0.0.1" ];
      log-driver = "journald";
      registry-mirrors = [ "https://mirror.gcr.io" ];
      storage-driver = "overlay2";
      runtimes = {
        nvidia = {
          path = "nvidia-container-runtime";
          runtimeArgs = [];
        };
      };
    };
  };
}
