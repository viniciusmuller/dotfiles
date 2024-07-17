{ config, pkgs, inputs, lib, colorscheme, ... }:

let
  fonts = with pkgs; [
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
    noto-fonts-cjk
  ];
  cli = with pkgs; [
    bandwhich # Network inspector
    ripgrep # File content finder
    htop # System monitor
    ncdu # Curses interface for `du`
    file # Show info about files
    fd # File finder
    unzip # Easily unzip files
    wget
  ];
  gui = with pkgs; [
    firefox # browser
  ];
  games = with pkgs; [ heroic ludusavi ];
in
{
  imports = [
    ../../pkgs/kitty.nix
  ];

  services.redshift = {
    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    temperature.day = 4500;
    temperature.night = 2800;
  };

  fonts.fontconfig.enable = true;

  home.packages = cli ++ gui ++ games ++ fonts;

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "gamer";
  home.homeDirectory = "/home/gamer";

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
