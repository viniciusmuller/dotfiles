{ pkgs, ... }:

{
  imports = [
    ../pkgs/base16-shell.nix # Different shell themes
    ../pkgs/zoxide.nix # Jump directories
    ../pkgs/bash.nix
    ../pkgs/nvim
    ../pkgs/readline # GNU readline input
    ../pkgs/git.nix
    ../pkgs/tmux # Terminal multiplexer
    ../pkgs/fzf.nix # Fuzzy finder
    ../pkgs/exa.nix # ls alternative
    ../pkgs/trash-cli.nix # Safer rm
    ../pkgs/htop.nix # Process viewer
    ../pkgs/direnv.nix
    ../pkgs/keychain.nix
    ../services/gpg-agent.nix
    ../pkgs/gpg.nix
    ../pkgs/irssi.nix
    ../pkgs/jq.nix # Work with json
    ../pkgs/bat.nix # File previewer
  ];

  home.packages = with pkgs; [
    bandwhich # Network inspector
    tealdeer # TLDR of man pages

    # Finders
    ripgrep # File content finder
    fd # File finder

    # Utils
    ncdu # Curses interface for `du`
    file # Show info about files
  ];
}
