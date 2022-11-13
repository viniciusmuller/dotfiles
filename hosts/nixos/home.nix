{ config, pkgs, inputs, lib, username, colorscheme, ... }:

let
  rebuild-alias = {
    rb = "sudo nixos-rebuild switch --flake '.#nixos'";
  };
  fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  cli = with pkgs; [
    bandwhich # Network inspector
    ripgrep # File content finder
    bottom # System monitor
    ncdu # Curses interface for `du`
    file # Show info about files
    fd # File finder
    unzip # Easily unzip files
    pfetch # lightweight neofetch
    git-imerge
    helix # text editor
  ];
  gui = with pkgs; [
    # thunderbird # email client
    insomnia # Request testing
    beekeeper-studio # database client
    # mupdf # Pdf viewer
    anki-bin # Spaced repetition
    # krita # Digital art
    firefox
    jellyfin-media-player
    calibre # Ebook manager
    element-desktop # Matrix client
    logseq # Note taking app
    mupdf # PDF reader
    lapce # graphical text editor
    godot_4 # Game engine
    spotify
  ];
  games = with pkgs; [
    # nethack
    # cataclysm-dda
  ];
  proprietary = with pkgs; [ discord ];
in
{
  imports = [
    ../../utils/scripts
    ../../profiles/haskell # ghci customization

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/bash.nix # Shell
    ../../pkgs/starship.nix # Shell prompt
    ../../pkgs/nix-index.nix # Show nixpkgs' packages of uninstalled binaries
    ../../pkgs/zoxide.nix # Jump directories
    ../../pkgs/editors/nvim # Modal text editor
    # ../../pkgs/editors/doom
    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/bat.nix # File previewer
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/newsboat.nix # RSS Reader
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/lazygit.nix # Git TUI client
    ../../pkgs/direnv.nix # Manages project environments
    ../../pkgs/keychain.nix
    ../../pkgs/gpg.nix
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/so.nix # StackExchange TUI
    ../../pkgs/nnn.nix # File manager
    ../../pkgs/tiny.nix # IRC Client
    ../../services/gpg-agent.nix
    ../../services/gammastep.nix # Screen temperature manager

    # GUI
    # ../../pkgs/wayst.nix # terminal emulator
    ../../pkgs/kitty.nix
    ../../pkgs/editors/vscodium # Text editor
    ../../pkgs/pomatez.nix
    # ../../pkgs/editors/emacs # Another text editor
    # ../../pkgs/beekeeper-studio.nix # Database manager
    # ../../pkgs/lutris.nix
    # ../../pkgs/obs-studio.nix # Screen recording
    # ../../pkgs/mangohud.nix # Performance overlay for games
    # ../../pkgs/psst.nix # Spotify client (currently broken)
    ../../pkgs/gtk.nix
    ../../pkgs/qt.nix

    # Games
    # ../../pkgs/games/dwarf-fortress
  ];

  # TODO: Apparently ghosts are trying to set my fontconfig.enable to false
  fonts.fontconfig.enable = lib.mkForce true;

  dconf.settings = {
    "org/gnome/desktop/peripherals/trackball" = {
      "middle-click-emulation" = true;
      "scroll-wheel-emulation-button" = 8;
    };
    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = ":minimize,maximize,close";
    };
  };

  programs.bash.initExtra = ''
    export PATH="$PATH:/home/vini/.dotnet/tools"
  '';

  home.packages = cli ++ gui ++ games ++ proprietary;

  programs.bash.shellAliases = rebuild-alias;

  nixpkgs.config.allowUnfree = true;

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
