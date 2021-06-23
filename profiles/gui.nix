{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/vscodium
    ../services/dunst.nix # Notification daemon
    ../services/picom.nix # Compositor
    ../pkgs/chromium.nix
    ../pkgs/kitty.nix # Terminal
  ];

  home.packages = with pkgs; [
    dmenu # Launcher
    st # Terminal
    picom # Compostior
    dunst # Desktop notifications daemon
    sxiv # Simple X image viewer
    flameshot # Screenshots
    mupdf # Pdf viewer
    feh # Background setter
    bitwarden # Password manager
    anki # Spaced repetition
    libnotify # notify-send
    wmctrl # Helper for window managers
  ];
}
