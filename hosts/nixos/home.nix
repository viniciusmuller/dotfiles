{ config, pkgs, prelude, ... }:

let
  rebuild-alias = {
    rb = "sudo nixos-rebuild switch --flake '.#nixos'";
  };
in
{
  imports = [
    ../../profiles/ricing.nix
    ../../utils/scripts

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/bash.nix # Shell
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
    ../../pkgs/lazydocker.nix # Docker TUI client
    ../../pkgs/direnv.nix # Manages project environments
    ../../pkgs/keychain.nix
    ../../services/gpg-agent.nix
    ../../pkgs/gpg.nix
    ../../pkgs/starship.nix # Awesome shell prompt
    # ../../pkgs/irssi.nix # IRC Client
    ../../pkgs/jq.nix # Work with json

    # GUI
    # ../../pkgs/editors/vscodium # Text editor
    ../../pkgs/pomatez.nix # Pomodoro app
    # ../../pkgs/editors/emacs # Another text editor
    ../../pkgs/chromium.nix # Browser
    ../../pkgs/bitwarden.nix # Password manager
    ../../pkgs/beekeeper-studio.nix # Database manager
    # ../../pkgs/obs-studio.nix # Screen recording
    # ../../pkgs/mangohud.nix # Performance overlay for games
    # ../../pkgs/psst.nix

    # Games
    # ../../pkgs/games/dwarf-fortress.nix
    # ../../pkgs/games/unreal-world.nix
  ];

  home.packages = with pkgs; [
    # CLI
    bandwhich # Network inspector
    tealdeer # TLDR of man pages
    ripgrep # File content finder
    taskell # TUI Kanban
    gomuks # Matrix TUI client
    bottom # System monitor
    nmap # Network scanner
    ncdu # Curses interface for `du`
    file # Show info about files
    fd # File finder
    gh # GitHub CLI

    # GUI
    # element-desktop # Matrix client
    # neovide # Neovim graphical frontend
    insomnia # Request testing
    mupdf # Pdf viewer
    anki # Spaced repetition
    krita # Digital art

    # Unfree
    # obsidian
    discord
    spotify

    # Games
    # cataclysm-dda
    # nethack
    # brogue
  ];

  programs.zsh.shellAliases = rebuild-alias;
  programs.bash.shellAliases = rebuild-alias;
  programs.fish.shellAliases = rebuild-alias;

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
