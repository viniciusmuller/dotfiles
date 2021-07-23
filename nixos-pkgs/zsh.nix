{ pkgs, ... }:

{
  # We just need to add zsh to the system packages,
  # so we can use chsh to change the default shell to zsh
  users.extraUsers.vini.shell = pkgs.zsh;
  home-manager.users.vini = import ../pkgs/zsh.nix;
}
