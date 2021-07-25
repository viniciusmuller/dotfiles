{ pkgs, ... }:

{
  imports = [
    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/zoxide.nix # Jump directories
    ../../pkgs/bash.nix
    ../../pkgs/nvim
    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/htop.nix # Process viewer
    ../../pkgs/keychain.nix
    ../../pkgs/gpg.nix
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/bat.nix # File previewer

    # Services
    ../../services/gpg-agent.nix
    ../../services/dunst.nix

    # GUI
    ../../pkgs/chromium.nix # Web browser
    ../../pkgs/bitwarden.nix # Password manager
    ../../pkgs/blugon # Screen temperature manager
  ];

  home.packages = with pkgs; [
    # GUI
    discord
    spotify

    # CLI
    bandwhich # Network inspector
    tealdeer # TLDR of man pages
    ripgrep # File content finder
    fd # File finder
    ncdu # Curses interface for `du`
    file # Shows info about files
    neofetch # Shows system information
    pfetch # Smaller neofetch

    # TODO: required by https://github.com/arcticlimer/helpepper
    # Turn this repository into a flake and use it here
    sox
  ];

  programs.bash = {
    # Source nix
    initExtra = ". ~/.nix-profile/etc/profile.d/nix.sh";
    shellAliases = {
      pacs = "sudo pacman -S";
      pacr = "sudo pacman -Rns";
      rb = "home-manager switch --flake .#arch";
    };
  };

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
