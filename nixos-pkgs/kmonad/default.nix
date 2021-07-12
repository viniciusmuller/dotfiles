{ pkgs, ... }:

let
  kmonad = (import ../../pkgs/kmonad/derivation.nix) pkgs;
in
{
  imports = [
    ./kmonad.nix
  ];

  services.kmonad = {
    enable = true;
    configfiles = [ ../../pkgs/kmonad/configs/ck61.kbd ];
    package = kmonad;
  };

  services.xserver = {
    xkbOptions = "compose:ralt";
    layout = "us";
  };

  users.extraUsers.vini = {
    extraGroups = [ "input" "uinput" ];
  };
}
