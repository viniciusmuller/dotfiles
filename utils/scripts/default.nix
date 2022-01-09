{ pkgs, ... }:

{
  # TODO: Remove this file, each profile should import the scripts that it wants
  # to use.
  imports = [
    ./loadgpg.nix
    ./loadssh.nix
    ./toggle_layout.nix
    ./backup_home.nix
    ./termbin.nix
    ./sprunge.nix
    ./makeflake.nix
  ];
}
