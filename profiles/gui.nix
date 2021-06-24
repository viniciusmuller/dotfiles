{ pkgs, ... }:

# Useful GUI programs in most desktop environments
{
  imports = [
    ../pkgs/vscodium
    ../pkgs/chromium.nix # Browser
    ../pkgs/bitwarden.nix # Password manager
  ];

  home.packages = with pkgs; [
    sxiv # Simple X image viewer
    mupdf # Pdf viewer
    anki # Spaced repetition
    libnotify # notify-send
  ];
}
