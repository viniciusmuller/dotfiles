{ config, lib, pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        userSettings = {
          "editor.rulers" = [ 80 120 ];

          "workbench.colorTheme" = "One Dark Pro";
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.startupEditor" = "newUntitledFile";

          "window.titleBarStyle" = "custom";
          "window.zoomLevel" = -1;
        };
        extensions = with pkgs.vscode-extensions; [
            # Aesthetic
            coenraads.bracket-pair-colorizer-2 
            # One dark pro theme
            zhuangtongfa.material-theme
            # Icon theme
            pkief.material-icon-theme 
            # Some vim keybindings
            vscodevim.vim

            # Nix
            jnoortheen.nix-ide
            brettm12345.nixfmt-vscode

            # Rust
            matklad.rust-analyzer

            # Haskell
            haskell.haskell
            justusadam.language-haskell

            # Elixir
            jakebecker.elixir-ls
        ];
    };
}

