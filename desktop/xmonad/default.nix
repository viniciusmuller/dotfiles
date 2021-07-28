{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.xmonad = {
      enable = true;
      config = ./config.hs;
      extraPackages = hp: [
        hp.xmonad-contrib
      ];
    };
  };

  home-manager.users.vini = {
    imports = [
      ../../pkgs/suckless/dmenu.nix
      ../../services/dunst.nix # Notification daemon
      # ../../services/picom.nix # Compositor
      ../../pkgs/kitty.nix # Terminal
      ../../pkgs/blugon # Screen temperature manager
      ../../pkgs/xbanish.nix # Hides the mouse when using the keyboard
    ];

    home.packages = with pkgs; [
      flameshot # Screenshots
      wmctrl # Helper for window managers
      xorg.xmessage # Xmonad uses this to show help
      xmobar
    ];

    home.file = {
      ".xinitrc".source = ./.xinitrc;
      ".xmobarrc".source = ./xmobar.hs;
    };
  };
}
