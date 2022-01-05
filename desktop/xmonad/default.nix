{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
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
      ../../services/flameshot.nix # Screenshots
      ../../pkgs/kitty.nix # Terminal
      ../../pkgs/betterlockscreen.nix # Screen locker
    ];

    home.packages = with pkgs; [
      xorg.xmessage # Xmonad uses this to show help
      xmobar # Status bar for xmonad
      xbanish # Hides the mouse when using the keyboard
    ];

    home.file = {
      # ".xinitrc".source = ./.xinitrc;
      ".xmobarrc".source = ./xmobar.hs;
    };
  };
}
