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

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.emacs-all-the-icons-fonts
  ];

  # TODO: Create `rb` alias
  programs.bash = {
    # Source nix
    initExtra = ". ~/.nix-profile/etc/profile.d/nix.sh";
    shellAliases.rb = "home-manager switch --flake .#linux";
  };

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
