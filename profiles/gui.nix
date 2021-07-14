{ pkgs, ... }:

# Useful GUI programs in most desktop environments
{
  imports = [
    ../pkgs/vscodium
    ../pkgs/emacs
    ../pkgs/chromium.nix # Browser
    ../pkgs/bitwarden.nix # Password manager
    ../pkgs/blugon # Screen temperature manager
    ../pkgs/xbanish.nix # Hides the mouse when using the keyboard
    ../pkgs/beekeeper-studio.nix
    # ../pkgs/pomotroid.nix
  ];

  home.packages = with pkgs; [
    mupdf # Pdf viewer
    libnotify # notify-send
    anki # Spaced repetition
    insomnia
  ];
}
