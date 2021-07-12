{pkgs, home-manager, ...}:

{
  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";
  home-manager.users.vini = import ../pkgs/suckless/slock.nix;
}

