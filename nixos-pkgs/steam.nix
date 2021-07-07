{pkgs, home-manager, ...}:

{
  hardware.opengl.driSupport32Bit = true;
  home-manager.users.vini = import ../profiles/games/steam.nix;
}
