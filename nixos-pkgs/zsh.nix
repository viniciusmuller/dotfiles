{ pkgs, username, ... }:

{
  users.extraUsers.${username}.shell = pkgs.zsh;
  home-manager.users.${username} = import ../pkgs/zsh.nix;
}
