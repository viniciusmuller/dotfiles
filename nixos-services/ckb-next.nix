{ pkgs, ... }:

let
  # TODO: Use upstream when this gets merged
  ckb-next = pkgs.ckb-next.overrideAttrs (_:
    {
      src = pkgs.fetchFromGitHub {
        owner = "arcticlimer";
        repo = "ckb-next";
        rev = "d403b2b947422c417d283154f3700c9a83ab4d0c";
        sha256 = "sha256-KMKk5XHTVge4IQ4SFdzXo7l6RZy+/rGkM0nGZ6tIqfg=";
      };
    }
  );
in
{
  hardware.ckb-next = {
    enable = true;
    package = ckb-next;
  };

  systemd.user.services.ckb-next = {
    after = [ "default.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${ckb-next}/bin/ckb-next -b";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
