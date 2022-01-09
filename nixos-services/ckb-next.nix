{ pkgs, config, colorscheme, ... }:

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
  colors = colorscheme.colors;
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

  # TODO: Make this reload when the colorscheme changes
  # systemd.user.services.ckb-nix-colors = {
  #   after = [ "ckb-next.target" ];
  #   serviceConfig = {
  #     Type = "simple";
  #     ExecStart = "${pkgs.bash}/bin/sh -c '${pkgs.coreutils}/bin/echo rgb ${colors.base0C}ff > /tmp/ckbpipe000'";
  #     Restart = "on-failure";
  #     RestartSec = 5;
  #   };
  #   # reloadIfChanged = true;
  # };
}
