{ config, pkgs, ... }:

{
  imports = [
    ../../desktop/dwm
    ../../profiles/ricing.nix
    ../../profiles/gui.nix
    ../../profiles/cli.nix
    ../../profiles/development
    ../../profiles/games
    ../../utils/scripts
  ];

  home.packages = with pkgs; [
    obsidian
    discord
    spotify
    teams
    slack

    # TODO: required by https://github.com/arcticlimer/helpepper
    # Turn this repository into a flake and use it here
    sox
  ];

  # TODO: Find a better place for this
  programs.bash.shellAliases.rb = "sudo nixos-rebuild switch --flake .#nixos";

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vini";
  home.homeDirectory = "/home/vini";

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
