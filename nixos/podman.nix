{ config, pkgs, ... }:

{
  # Configure podman
  virtualisation = {
    containers.enable = true;
    containers.containersConf.settings = {
      # Force systemd as the cgroup manager and configure the default
      # cgroup_parent as 'user.slice' to force compatibility across users.
      engine.cgroup_manager = "systemd";
      engine.cgroup_parent = "user.slice";
    };
    containers.registries.search = [ "docker.io" ];
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  # add podman and podman-compose
  environment.systemPackages = with pkgs; [
      podman-compose
      slirp4netns # user-mode networking
      fuse-overlayfs
  ];

  # --- To allow containers to bind to host ports < 1024, set the following:  ---
  # boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
  # networking.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
  # In docker-compose.yaml:
    # cap_add:
    #   - NET_BIND_SERVICE
  # -----------------------------------------------------------------------------

  # Enable lingering so containers persist after ssh exit
  users.users.joermo.linger = true;

  # Force session initialization for better compatibility with systemd
  security.pam.services.sshd.startSession = true;
}
