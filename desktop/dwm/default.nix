{ pkgs, ... }:

# Config for the dynamic window manager
{
  imports = [
    ../../pkgs/suckless/slstatus.nix # dwm statusbar
    ../../pkgs/suckless/dmenu.nix # Launcher
    ../../pkgs/suckless/slock.nix # Screen locker
    ../../pkgs/suckless/dwm.nix # Tiling window manager

    ../../services/dunst.nix # Notification daemon
    ../../services/picom.nix # Compositor
    ../../pkgs/kitty.nix # Terminal
  ];

  home.packages = with pkgs; [
    flameshot # Screenshots
    wmctrl # Helper for window managers

    # TODO: Try to make startx work OOTB on non-nixos systems
    # Xserver
    xorg.xorgserver
    xorg.xinit

    # Xorg input modules
    xorg.xf86inputsynaptics
    xorg.xf86inputlibinput
    xorg.xf86inputevdev
    xorg.xf86inputkeyboard
    xorg.xf86inputmouse

    # Xorg video modules
    xorg.xf86videonouveau
    xorg.xf86videointel
    xorg.xf86videoati

    xorg.xinput

    # Maybe this is needed
    xorg.xauth
  ];

  home.file = {
    ".config/dwm/autostart.sh".source = ./autostart.sh;
    ".xinitrc".text = ''
      dunst &
      blugon &
      xbanish &
      flameshot &
      exec dwm
      '';
  };
}
