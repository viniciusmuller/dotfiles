{ config, pkgs, ... }:

{
  imports = [
    ../../desktop/dwm
    ../../profiles/ricing.nix
    ../../utils/scripts

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/zoxide.nix # Jump directories
    ../../pkgs/bash.nix # Good old bash
    ../../pkgs/nvim # Modal text editor
    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/htop.nix # Process viewer
    ../../pkgs/direnv.nix
    ../../pkgs/keychain.nix
    ../../services/gpg-agent.nix
    ../../pkgs/gpg.nix
    ../../pkgs/irssi.nix # IRC Client
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/bat.nix # File previewer

    # GUI
    ../../pkgs/vscodium # Text editor
    ../../pkgs/emacs # Another text
    ../../pkgs/chromium.nix # Browser
    ../../pkgs/bitwarden.nix # Password manager
    ../../pkgs/blugon # Screen temperature manager
    ../../pkgs/xbanish.nix # Hides the mouse when using the keyboard
    ../../pkgs/beekeeper-studio.nix # Database manager

    # Games
    ../../pkgs/games/dwarf-fortress.nix
  ];

  home.packages = with pkgs; [
    # CLI
    bandwhich # Network inspector
    tealdeer # TLDR of man pages
    ripgrep # File content finder
    nmap # Network scanner
    ncdu # Curses interface for `du`
    file # Show info about files
    fd # File finder

    # GUI
    element-desktop # Matrix client
    libnotify # notify-send
    insomnia # Request testing
    mupdf # Pdf viewer
    anki # Spaced repetition
    # TODO: Use ../../pkgs/pomotroid.nix #
    gnome.pomodoro # Pomodoro app

    # Unfree
    obsidian
    discord
    spotify
    teams
    slack

    # Games
    cataclysm-dda
    nethack
    brogue

    # TODO: required by https://github.com/arcticlimer/helpepper
    # Turn this repository into a flake and use it here
    sox
  ];

  # TODO: Find a better place for this
  programs.bash.shellAliases.rb = "sudo nixos-rebuild switch --flake .#nixos";

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vini";
  home.homeDirectory = "/home/vini";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
