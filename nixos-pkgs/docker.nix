{ pkgs, home-manager, username, ... }:

{
  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];

  home-manager.users.${username} = import ../pkgs/docker.nix;
}
