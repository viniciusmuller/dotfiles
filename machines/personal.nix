{ config, pkgs, ... }:

{
    imports = [
        ../profiles/cli.nix
        ../profiles/gui.nix
    ];
    
    nixpkgs.config.allowUnfree = true;
}