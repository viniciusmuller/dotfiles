{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/zoxide.nix # Jump directories
    ../pkgs/bash.nix
    ../pkgs/nvim.nix
    ../pkgs/readline # GNU readline input
    ../pkgs/git.nix
    ../pkgs/tmux # Terminal multiplexer
    ../pkgs/fzf.nix # Fuzzy finder
  ];

  home.packages = with pkgs; [
    lazydocker # Docker TUI
    bandwhich # Network inspector
    neofetch # Display system info
    tealdeer # TLDR of man pages
    rmtrash # Safer /bin/rm
    exa # ls alternative

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
  ];
}
