{ pkgs, ... }:

{
  imports = [
    ../../desktop/dwm
    ../../profiles/ricing.nix
    ../../profiles/cli.nix
    ../../utils/scripts

    ../../pkgs/chromium.nix # Browser
    ../../pkgs/bitwarden.nix # Password manager
    ../../pkgs/blugon # Screen temperature manager
    ../../pkgs/xbanish.nix # Hides the mouse when using the keyboard
  ];

  home.packages = with pkgs; [
    discord
    spotify
  ];

  # TODO: Create `rb` alias

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
