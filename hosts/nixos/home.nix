{ config, pkgs, inputs, lib, username, colorscheme, ... }:

let
  rebuild-alias = {
    rb = "sudo nixos-rebuild switch --flake '.#nixos'";
  };
in
{
  imports = [
    ../../utils/scripts
    ../../profiles/haskell # ghci customization

    # CLI
    # ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/bash.nix # Shell
    ../../pkgs/nix-index.nix # Show nixpkgs' packages of uninstalled binaries
    ../../pkgs/zoxide.nix # Jump directories
    ../../pkgs/editors/nvim # Modal text editor
    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/bat.nix # File previewer
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/fcp.nix # cp alternative
    ../../pkgs/newsboat.nix # RSS Reader
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/lazygit.nix # Git TUI client
    # ../../pkgs/lazydocker.nix # Docker TUI client
    ../../pkgs/direnv.nix # Manages project environments
    ../../pkgs/keychain.nix
    ../../services/gpg-agent.nix
    ../../services/gammastep.nix
    ../../pkgs/gpg.nix
    ../../pkgs/starship.nix # Awesome shell prompt
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/so.nix # StackExchange TUI
    ../../pkgs/gdb-dashboard.nix
    ../../pkgs/nnn.nix # File manager
    ../../pkgs/bitwarden.nix # Password manager
    # ../../pkgs/irssi.nix # IRC Client
    ../../pkgs/hexchat.nix # IRC Client

    # GUI
    ../../pkgs/editors/vscodium # Text editor
    # ../../pkgs/pomatez.nix # Pomodoro app
    # ../../pkgs/editors/emacs # Another text editor
    ../../pkgs/chromium.nix # Browser
    ../../pkgs/firefox.nix # Browser
    ../../pkgs/beekeeper-studio.nix # Database manager
    # ../../pkgs/lutris.nix
    # ../../pkgs/obs-studio.nix # Screen recording
    # ../../pkgs/mangohud.nix # Performance overlay for games
    # ../../pkgs/psst.nix
    ../../pkgs/gtk.nix
    ../../pkgs/qt.nix

    ../../desktop/sway

    # Theming
    inputs.nix-colors.homeManagerModule
  ];

  colorscheme = inputs.nix-colors.colorSchemes.tokyonight;

  # TODO: Apparently ghosts are trying to set my fontconfig.enable to false
  fonts.fontconfig.enable = lib.mkForce true;

  home.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # CLI
    # python39Packages.gigalixir
    bandwhich # Network inspector
    tealdeer # TLDR of man pages
    ripgrep # File content finder
    bottom # System monitor
    ncdu # Curses interface for `du`
    file # Show info about files
    fd # File finder
    neofetch # I use NixOS btw

    # GUI
    element-desktop # Matrix client
    insomnia # Request testing
    mupdf # Pdf viewer
    anki # Spaced repetition
    # krita # Digital art
    obsidian

    # Unfree
    discord
    spotify
  ];

  programs.zsh.shellAliases = rebuild-alias;
  programs.bash.shellAliases = rebuild-alias;
  programs.fish.shellAliases = rebuild-alias;

  nixpkgs.config.allowUnfree = true;

  # TODO: Make this work again
  # home.sessionVariables = {
  #   GTK_IM_MODULE = "cedilla";
  #   QT_IM_MODULE = "cedilla";
  # };

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

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
