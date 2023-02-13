{ config, pkgs, lib, username, ... }:

let
  nixgl = pkgs.nixgl;
  nixGLWrap = pkg: pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
    mkdir $out
    ln -s ${pkg}/* $out
    rm $out/bin
    mkdir $out/bin
    for bin in ${pkg}/bin/*; do
     wrapped_bin=$out/bin/$(basename $bin)
     echo "exec ${lib.getExe nixgl.auto.nixGLDefault} $bin \$@" > $wrapped_bin
     chmod +x $wrapped_bin
    done
  '';
  fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
  cli = with pkgs; [
    bandwhich # Network inspector
    ripgrep # File content finder
    htop # System monitor
    ncdu # Curses interface for `du`
    file # Show info about files
    fd # File finder
    unzip # Easily unzip files
    neofetch
    pfetch # lightweight neofetch
    restic # backups
  ];
  gui = with pkgs; [
    retroarch
    okular # ebook reader
    thunderbird # email client
    gnome-solanum # pomodoro timer
    (nixGLWrap anki-bin) # Spaced repetition
    (nixGLWrap beekeeper-studio) # database client
    firefox # browser
    calibre # Ebook manager
    logseq # Note taking app
    sioyek # technical paper reader
    # element-desktop # Matrix client
    # godot_4 # Game engine
    # libresprite # pixel art editor
    # antimicroX # convert joystick input to keyboard input
  ];
  games = with pkgs; [ ];
  proprietary = with pkgs; [ discord ];
in
{
  imports = [
    ../../utils/scripts
    # ../../profiles/haskell # ghci customization

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/bash.nix # Shell
    # ../../pkgs/nix-index.nix # Show nixpkgs' packages of uninstalled binaries
    ../../pkgs/zoxide.nix # Jump directories

    ../../pkgs/editors/nvim # Modal text editor
    ../../pkgs/editors/vscodium # Text editor

    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/bat.nix # File previewer
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/newsboat.nix # RSS Reader
    ../../pkgs/trash-cli.nix # Safer rm
    # ../../pkgs/lazygit.nix # Git TUI client
    ../../pkgs/direnv.nix # Manages project environments
    ../../pkgs/keychain.nix
    ../../pkgs/gpg.nix
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/nnn.nix # File manager
    ../../pkgs/tiny.nix # IRC Client
    ../../services/gpg-agent.nix
    # ../../services/gammastep.nix # Screen temperature manager

    # GUI
    # ../../pkgs/wayst.nix # terminal emulator
    ../../pkgs/kitty.nix
    # ../../pkgs/pomatez.nix
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

  services.redshift = {
    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    temperature.day = 4500;
    temperature.night = 2800;
  };

  programs.kitty.package = nixGLWrap pkgs.kitty;

  programs.bash = {
    # Source nix
    # initExtra = ". ~/.nix-profile/etc/profile.d/nix.sh";
    shellAliases = {
      rb = "nix build --impure .#homeConfigurations.debian.activationPackage && result/activate";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = ":minimize,maximize,close";
    };
  };

  fonts.fontconfig.enable = true;

  home.packages = cli ++ gui ++ games ++ proprietary;

  nixpkgs.config.allowUnfree = true;

  # allow home-manager programs to be discovered by app launchers
  home.file.".xsessionrc".text = ''
    . "/home/${username}/.nix-profile/etc/profile.d/hm-session-vars.sh"
  '';

  # Make home-manager work better on non-NixOS distros
  targets.genericLinux.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
  # home.stateVersion = "23.05";
}
