{ config, lib, pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        userSettings = {
          "editor.rulers" = [ 80 120 ];
          "window.titleBarStyle" = "custom";
        };
        extensions = with pkgs.vscode-extensions; [
            jnoortheen.nix-ide
            matklad.rust-analyzer
        ];
    };
}

