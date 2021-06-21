{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        ghc
        nixfmt
    ];

    programs.vscode.extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        brettm12345.nixfmt-vscode
    ];
}