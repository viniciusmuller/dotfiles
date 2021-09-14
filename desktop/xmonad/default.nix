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
      ../../pkgs/rofi # Application launcher and window switcher
      ../../services/dunst.nix # Notification daemon
      ../../services/picom.nix # Compositor
      ../../pkgs/kitty.nix # Terminal
      # ../../pkgs/alacritty.nix # Terminal
      ../../pkgs/blugon # Screen temperature manager
    ];

    home.packages = with pkgs; [
      flameshot # Screenshots
      xorg.xmessage # Xmonad uses this to show help
      xmobar # Status bar for xmonad
      nitrogen # Wallpaper setter
      xbanish # Hides the mouse when using the keyboard
      betterlockscreen # Screen locker
    ];

    home.file = {
      ".xinitrc".source = ./.xinitrc;
      ".xmobarrc".source = ./xmobar.hs;
    };
  };
}
