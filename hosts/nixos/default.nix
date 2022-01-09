# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, username, ... }:

{
  imports =
    [
      ../../desktop/xmonad
      ../../desktop/dwm
      # ../../desktop/kde

      # TODO: Try to use a specific partition schema and use the autoFormat
      # option inside hardware-configuration instead of hardcoding partuuids.
      ./hardware-configuration.nix
      # ../../nixos-pkgs/virtualbox.nix
      # ../../nixos-pkgs/manpages.nix
      ../../nixos-pkgs/docker.nix
      # ../../nixos-pkgs/steam.nix
      # ../../nixos-pkgs/slock.nix
      # ../../nixos-pkgs/zsh.nix
      ../../nixos-pkgs/kmonad
      # ../../nixos-pkgs/wine.nix
      ./prime.nix
      # ./gpu-passthrough.nix

      ../../nixos-services/noisetorch.nix
      ../../nixos-services/ckb-next.nix

      # Grub
      ../../nixos-pkgs/grub/themes/fallout.nix
      ../../nixos-pkgs/grub/os-prober.nix

      ../../nixos-pkgs/display-managers/sddm
    ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      gtkUsePortal = true;
    };
  };

  nix = {
    # TODO: Find better place for this
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      options = "--delete-older-than 2d";
    };

    autoOptimiseStore = true;
  };

  # TODO: Figure out how to set dark theme to this prompt.
  programs.ssh.askPassword = "${pkgs.libsForQt5.ksshaskpass}/bin/ksshaskpass";

  fonts.fontconfig.enable = true;
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  boot = {
    cleanTmpDir = true;
    kernel.sysctl = {
      # Wine was suggesting this
      "dev.i915.perf_stream_paranoid" = 0;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # TODO: Move this to sway module
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Configure keymap in X11
  services.xserver.layout = "us";

  # Audio with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "changeme";
  };

  environment.systemPackages = with pkgs; [ ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
