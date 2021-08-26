{ pkgs, ... }:

# Config for the dynamic window manager
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.dwm.enable = true;
  };

  home-manager.users.vini = {
    imports = [
      ../../pkgs/suckless/slstatus.nix # dwm statusbar
      ../../pkgs/suckless/dmenu.nix # Launcher
      ../../pkgs/suckless/slock.nix # Screen locker
      ../../services/dunst.nix # Notification daemon
      ../../services/picom.nix # Compositor
      ../../pkgs/kitty.nix # Terminal
      ../../pkgs/blugon # Screen temperature manager
    ];

    home.packages = with pkgs; [
      flameshot # Screenshots
      wmctrl # Helper for window managers
      xbanish # Hides the mouse when using the keyboard
    ];

    home.file = {
      ".config/dwm/autostart.sh".source = ./autostart.sh;
      ".xinitrc".source = ./.xinitrc;
    };
  };
}
