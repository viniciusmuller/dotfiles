{ pkgs, ... }:

# Useful GUI programs in most desktop environments
{
  imports = [
    ../pkgs/vscodium
    # ../pkgs/emacs.nix TODO: Add emacs
    ../pkgs/chromium.nix # Browser
    ../pkgs/bitwarden.nix # Password manager
    ../pkgs/blugon # Screen temperature manager
    ../pkgs/xbanish.nix # Hides the mouse when using the keyboard
  ];

  home.packages = with pkgs; [
    sxiv # Simple X image viewer
    mupdf # Pdf viewer
    anki # Spaced repetition
    libnotify # notify-send
  ];
}
