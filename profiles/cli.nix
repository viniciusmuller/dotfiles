{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/base16-shell.nix # Different shell themes
    ../pkgs/zoxide.nix # Jump directories
    ../pkgs/bash.nix
    ../pkgs/nvim.nix
    ../pkgs/readline # GNU readline input
    ../pkgs/git.nix
    ../pkgs/tmux # Terminal multiplexer
    ../pkgs/fzf.nix # Fuzzy finder
    ../pkgs/exa.nix # ls alternative
    ../pkgs/trash-cli.nix # Safer rm
    ../pkgs/direnv.nix
    ../pkgs/keychain.nix
    ../pkgs/kmonad.nix
  ];

  home.packages = with pkgs; [
    lazydocker # Docker TUI
    bandwhich # Network inspector
    neofetch # Display system info
    tealdeer # TLDR of man pages
    lazygit # Git TUI

    # Finders
    ripgrep # File content finder
    fd # File finder

    # Editors
    vim # Modal text editor

    # Utils
    xsv # Work with csv
    jq # Work with json
    bat # File viewer
    stow # Symlinks manager
    ncdu # Curses interface for `du`
    vifm # File manager
    tokei # Show lines of code of a project
  ];
}
