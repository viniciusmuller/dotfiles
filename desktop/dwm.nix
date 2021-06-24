{ pkgs, ... }:

# Config for the dynamic window manager
{
  imports = [
    ../pkgs/suckless/slstatus.nix # dwm statusbar
    ../pkgs/suckless/dmenu.nix # Launcher
    ../pkgs/suckless/slock.nix # Screen locker
    ../services/dunst.nix # Notification daemon
    ../services/picom.nix # Compositor
    ../pkgs/kitty.nix # Terminal
  ];

  home.packages = with pkgs; [
    flameshot # Screenshots
    wmctrl # Helper for window managers
  ];
}
