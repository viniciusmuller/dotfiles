{ pkgs, home-manager, username, ... }:

{
  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";
  home-manager.users.${username} = import ../pkgs/suckless/slock.nix;
}

