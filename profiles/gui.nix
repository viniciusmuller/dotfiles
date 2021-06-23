{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/vscodium
    ../services/dunst.nix # Notification daemon
    ../services/picom.nix # Compositor
    ../pkgs/chromium.nix
    ../pkgs/kitty.nix # Terminal
    ../pkgs/suckless/dmenu.nix # Launcher
    ../pkgs/suckless/slock.nix # Screen locker
    ../pkgs/suckless/slstatus.nix # dwm statusbar
  ];

  home.packages = with pkgs; [
    wmctrl # Helper for window managers
    picom # Compostior
    dunst # Desktop notifications daemon
    sxiv # Simple X image viewer
    flameshot # Screenshots
    mupdf # Pdf viewer
    feh # Background setter
    bitwarden # Password manager
    anki # Spaced repetition
    libnotify # notify-send

    discord
  ];
}
