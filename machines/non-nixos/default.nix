{ pkgs, ... }:

{
  imports = [
    ../../desktop/dwm
    ../../profiles/ricing.nix
    ../../profiles/cli.nix
    ../../utils/scripts

    ../pkgs/chromium.nix # Browser
    ../pkgs/bitwarden.nix # Password manager
    ../pkgs/blugon # Screen temperature manager
    ../pkgs/xbanish.nix # Hides the mouse when using the keyboard
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
  # programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
