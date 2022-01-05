{ pkgs, ... }:

{
  programs.noisetorch.enable = true;

  systemd.user.services.noisetorch = {
    after = [ "default.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.noisetorch}/bin/noisetorch -i";
      # ExecStop = "${pkgs.noisetorch}/bin/noisetorch -u";
      Restart = "on-failure";
      RestartSec = 5;
    };
    environment = {
      PULSE_SERVER = "/run/user/1000/pulse/native";
    };
  };
}
