{ pkgs, ... }:

let
  kmonad = (import ./derivation.nix) pkgs;
in
{
  imports = [
    ./kmonad.nix
  ];

  services.kmonad = {
    enable = true;
    configfiles = [ ./config.kbd ];
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