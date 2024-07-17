{ config, pkgs, inputs, lib, username, colorscheme, ... }:

let
  rebuild-alias = {
    rb = "sudo nixos-rebuild switch --flake '.#nixos'";
  };
  fonts = with pkgs; [
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    noto-fonts-cjk
  ];
  cli = with pkgs; [
    bandwhich # Network inspector
    ripgrep # File content finder
    htop # System monitor
    ncdu # Curses interface for `du`
    file # Show info about files
    fd # File finder
    unzip # Easily unzip files
    fastfetch
    pfetch # lightweight neofetch
    git-imerge
    kubectl
    minikube
    restic # backups
    lm_sensors
    wget
    ollama
  ];
  gui = with pkgs; [
    easyeffects
    gnomeExtensions.easyeffects-preset-selector

    zathura
    beekeeper-studio # database client
    mpv # anki uses MPV to play audio
    anki-bin # Spaced repetition
    firefox # browser
    calibre # Ebook manager
    sioyek # technical paper reader
    vlc
    logseq
    joplin-desktop
  ];
  games = with pkgs; [ heroic ludusavi ];
  proprietary = with pkgs; [
    spotify
    # jetbrains.idea-ultimate
  ];
in
{
  imports = [
    ../../utils/scripts
    ../../profiles/haskell # ghci customization

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
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
    ../../pkgs/newsboat.nix # RSS Reader
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/direnv.nix # Manages project environments
    ../../pkgs/keychain.nix
    ../../pkgs/gpg.nix
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/nnn.nix # File manager
    ../../pkgs/tiny.nix # IRC Client
    ../../services/gpg-agent.nix
    # ../../services/gammastep.nix # Screen temperature manager
    ../../services/dunst.nix # notification daeomn

    # GUI
    # ../../pkgs/wayst.nix # terminal emulator
    ../../pkgs/kitty.nix
    ../../pkgs/editors/vscodium # Text editor
    ../../pkgs/pomatez.nix
    # ../../pkgs/mangohud.nix
    # ../../pkgs/editors/emacs # Another text editor
    # ../../pkgs/beekeeper-studio.nix # Database manager
    # ../../pkgs/lutris.nix
    # ../../pkgs/obs-studio.nix # Screen recording
    # ../../pkgs/mangohud.nix # Performance overlay for games
    # ../../pkgs/psst.nix # Spotify client (currently broken)
    # ../../pkgs/gtk.nix
    # ../../pkgs/qt.nix

    # Games
    # ../../pkgs/games/dwarf-fortress
  ];

  services.kdeconnect.enable = true;

  services.redshift = {
    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    temperature.day = 4500;
    temperature.night = 2800;
  };

  fonts.fontconfig.enable = true;

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = ":minimize,maximize,close";
    };
    "org/cinnamon/desktop/wm/preferences" = {
      "mouse-button-modifier" = "<Super>";
    };
  };

  home.packages = cli ++ gui ++ games ++ proprietary ++ fonts;

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
