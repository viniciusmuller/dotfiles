{ username, ... }:

{
  imports = [ ../nixos-services/tumbler.nix ];
  home-manager.users.${username} = import ../pkgs/thunar.nix;
}
