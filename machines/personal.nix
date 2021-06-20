{ config, pkgs, ... }:

{
    imports = [
        ../profiles/cli.nix
        ../profiles/gui.nix
        ../profiles/programming/haskell.nix
        ../profiles/programming/rust.nix
        ../profiles/programming/elixir.nix
    ];
    
    nixpkgs.config.allowUnfree = true;
}