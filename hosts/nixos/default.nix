# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, username, ... }:

{
  imports = [
    ../../desktop/dwm

    # TODO: Try to use a specific partition schema and use the autoFormat
    # option inside hardware-configuration instead of hardcoding partuuids.
    ./hardware-configuration.nix
    # ../../nixos-pkgs/manpages.nix
    # ../../nixos-pkgs/virt-manager.nix
    ../../nixos-pkgs/docker.nix
    ../../nixos-pkgs/steam.nix
    # ../../nixos-pkgs/thunar.nix
    # ../../nixos-pkgs/slock.nix
    # ../../nixos-pkgs/zsh.nix
    ../../nixos-pkgs/kmonad
    # ../../nixos-pkgs/wine.nix

    ../../nixos-services/noisetorch.nix
    ../../nixos-services/ckb-next.nix

    # Grub
    # ../../nixos-pkgs/grub/themes/fallout.nix
    ../../nixos-pkgs/grub/os-prober.nix

    ../../nixos-pkgs/display-managers/sddm
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.variables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  hardware.opengl.setLdLibraryPath = true;

  networking = {
    hostName = "nixos";

    # DNS
    networkmanager = {
      enable = true;
      dns = "none";
      ethernet.macAddress = "random";
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = true;
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };


  # Resolvconf is automatically picking up unwanted ISP's dns server ip and
  # giving it higher priority than `networking.nameservers`, so we just don't
  # use it and manually manage DNS.
  environment.etc = {
    "resolv.conf".text = "nameserver 1.1.1.3\n";
  };

  # Swap monitors
  services.xserver.displayManager.setupCommands = ''
    LEFT='DP-5'
    RIGHT='HDMI-0'
    ${pkgs.xorg.xrandr}/bin/xrandr --output $LEFT --left-of $RIGHT
  '';

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      options = "--delete-older-than 2d";
    };

    settings = {
      # Caching
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      auto-optimise-store = true;
    };
  };

  # TODO: Figure out how to set dark theme to this prompt.
  programs.ssh.askPassword = "${pkgs.libsForQt5.ksshaskpass}/bin/ksshaskpass";

  boot = {
    cleanTmpDir = true;
    kernel.sysctl = {
      # Wine was suggesting this
      "dev.i915.perf_stream_paranoid" = 0;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };


  # TODO: Move this to sway module
  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  # };

  # xdg = {
  #   portal = {
  #     enable = true;
  #     extraPortals = with pkgs; [
  #       xdg-desktop-portal-wlr
  #       xdg-desktop-portal-gtk
  #     ];
  #     gtkUsePortal = true;
  #   };
  # };


  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

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

    # Wireplumber
    wireplumber.enable = true;
    media-session.enable = false;

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "changeme";
  };

  environment.systemPackages = with pkgs; [ ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
