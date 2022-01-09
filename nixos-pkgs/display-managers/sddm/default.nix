{ pkgs, ... }:

let
  sddm-sugar-candy = pkgs.stdenv.mkDerivation rec {
    pname = "sddm-sugar-candy-theme";
    version = "1.6";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes/sugar-candy

      cat << EOT >> theme.conf.user
        ForceHideCompletePassword="true"
      EOT

      cp -aR $src/* theme.conf.user $out/share/sddm/themes/sugar-candy
    '';
    src = pkgs.fetchFromGitHub {
      owner = "Kangie";
      repo = "sddm-sugar-candy";
      rev = "a1fae5159c8f7e44f0d8de124b14bae583edb5b8";
      sha256 = "sha256-p2d7I0UBP63baW/q9MexYJQcqSmZ0L5rkwK3n66gmqM=";
    };
  };
in
{
  services.xserver = {
    enable = true;
    displayManager.sddm = {
      enable = true;
      theme = "sugar-candy";
    };
  };

  environment.systemPackages = [
    sddm-sugar-candy
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
