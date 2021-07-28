{pkgs, ...}:

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
      ../../pkgs/xmobar # Status bar
    ];

    home.packages = with pkgs; [
      flameshot # Screenshots
      wmctrl # Helper for window managers
    ];

    home.file = {
      ".xinitrc".text = builtins.readFile ./.xinitrc;
    };

    # TODO: Move to `services` folder #
    services.stalonetray = {
      enable = true;
      config = {};
    };
  };
}
