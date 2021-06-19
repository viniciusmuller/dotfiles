{ config, pkgs, ... }:

{
    imports = [
        ../pkgs/vscodium.nix
    ];

    home.packages = with pkgs; [
      dmenu     # Launcher
      firefox   # Browser
      kitty     # Terminal
      picom     # Compostior
      dunst     # Desktop notifications daemon
      sxiv      # Simple X image viewer
      flameshot # Screenshots
      mupdf     # Pdf viewer
      feh       # Background setter
    ];
}
