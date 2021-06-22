{ config, pkgs, ... }:

{
  imports = [
    ../pkgs/vscodium
    ../services/dunst.nix
  ];

  home.packages = with pkgs; [
    dmenu # Launcher
    firefox # Browser
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
