{ config, pkgs, ... }:

{
  imports = [
      ../../profiles/cli.nix
      ../../profiles/gui.nix
      ../../profiles/programming
  ];


  # TODO: Find a better place for this
  programs.bash.shellAliases.rb = "sudo nixos-rebuild switch --flake .#desktop";

  nixpkgs.config.allowUnfree = true;

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
