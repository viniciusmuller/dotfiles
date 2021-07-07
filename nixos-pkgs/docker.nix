{ pkgs, home-manager, ... }:

{
  virtualisation.docker.enable = true;
  users.users.vini.extraGroups = [ "docker" ];

  home-manager.users.vini = import ../pkgs/docker.nix;
}
