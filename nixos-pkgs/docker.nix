{ pkgs, home-manager, username, ... }:

{
  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];

  # https://github.com/containerd/containerd/issues/5502
  systemd.services = {
    kill-all-docker-containers = {
      description = "Kill all docker containers to prevent shutdown lag";
      enable = true;
      unitConfig = {
        DefaultDependencies = false;
        RequiresMountFor = "/";
      };
      before = [ "shutdown.target" "reboot.target" "halt.target" "final.target" ];
      wantedBy = [ "shutdown.target" "reboot.target" "halt.target" "final.target" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = pkgs.writeScript "docker-kill-all" ''
          #! ${pkgs.runtimeShell} -e
          ${pkgs.docker}/bin/docker ps --format '{{.ID}}' | xargs ${pkgs.docker}/bin/docker kill
        '';
      };
    };
  };
}
