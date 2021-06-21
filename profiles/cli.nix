{ config, pkgs, ... }:

{
    imports = [
        ../pkgs/bash.nix
        ../pkgs/nvim.nix
        ../pkgs/git.nix
    ];
    
    home.packages = with pkgs; [
      lazydocker # Docker TUI
      bandwhich  # Network inspector
      neofetch   # Display system info
      tealdeer   # TLDR of man pages
      rmtrash    # Safer /bin/rm
      exa        # ls alternative

      # Finders
      fzf       # Fuzzy finder
      ripgrep   # File content finder
      fd        # File finder

      # Editors
      vim       # Modal text editor

      # Utils
      zoxide    # Directory jumper
      xsv       # Work with csv
      jq        # Work with json
      bat       # File viewer
      stow      # Symlinks manager
      ncdu      # Curses interface for `du`
      tmux      # Terminal multiplexer
      vifm      # File manager
    ];
}