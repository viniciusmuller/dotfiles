{ pkgs, home-manager, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  programs.steam.enable = true;
}
