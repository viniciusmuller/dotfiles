{ config, pkgs, ... }:

{
    imports = [
        ../profiles/cli.nix
        ../profiles/gui.nix
        ../profiles/programming
    ];

    nixpkgs.config.allowUnfree = true;
}