{ pkgs, ... }:

let
  falloutGrubTheme = pkgs.fetchFromGitHub {
    owner = "shvchk";
    repo = "fallout-grub-theme";
    rev = "87e4e220e4ce84a22ae6858704c8e872699dc914";
    sha256 = "sha256-/OrOciVRaTuBEup1RWedWHZ0LNI+xF/NQnHHQkms6OI=";
  };
in
{
  boot.loader.grub = {
    extraConfig = ''
      set theme=($drive1)//themes/fallout-grub-theme/theme.txt
    '';
    splashImage = "${falloutGrubTheme}/background.png";
    font = "${falloutGrubTheme}/fixedsys-regular-32.pf2";
  };

  system.activationScripts.copyGrubTheme = ''
    mkdir -p /boot/themes
    cp -R ${falloutGrubTheme}/ /boot/themes/fallout-grub-theme
  '';
}
