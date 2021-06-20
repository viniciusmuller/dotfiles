{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        rustfmt
        clippy
        rustc
        cargo 
        gcc
    ];
}