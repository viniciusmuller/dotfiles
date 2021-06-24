{ pkgs, ... }:

# Useful GUI programs in most desktop environments
{
  imports = [
    ../pkgs/vscodium
    ../pkgs/chromium.nix # Browser
  ];

  home.packages = with pkgs; [
    sxiv # Simple X image viewer
    mupdf # Pdf viewer
    bitwarden # Password manager
    anki # Spaced repetition
    libnotify # notify-send
  ];
}
