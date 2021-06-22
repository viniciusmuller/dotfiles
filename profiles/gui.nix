{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/vscodium
    ../services/dunst.nix # Notification daemon
    ../pkgs/chromium.nix
  ];

  home.packages = with pkgs; [
    dmenu # Launcher
    kitty # Terminal
    st # Terminal
    picom # Compostior
    dunst # Desktop notifications daemon
    sxiv # Simple X image viewer
    flameshot # Screenshots
    mupdf # Pdf viewer
    feh # Background setter
    bitwarden # Password manager
  ];
}
