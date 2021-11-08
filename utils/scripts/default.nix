{ pkgs, ... }:

{
  imports = [
    ./loadgpg.nix
    ./loadssh.nix
    ./toggle_layout.nix
    ./backup_home.nix
  ];
}
