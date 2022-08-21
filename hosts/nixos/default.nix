# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, username, ... }:

{
  imports = [
    ../../desktop/xmonad

    # TODO: Try to use a specific partition schema and use the autoFormat
    # option inside hardware-configuration instead of hardcoding partuuids.
    ./hardware-configuration.nix
    ../../nixos-pkgs/docker.nix

    ../../nixos-services/noisetorch.nix
    ../../nixos-pkgs/steam.nix

    # Grub
    ../../nixos-pkgs/grub/os-prober.nix

    ../../nixos-pkgs/display-managers/lightdm.nix
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.variables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  hardware.opengl.setLdLibraryPath = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  services.xserver.desktopManager.gnome.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    gnome.cheese
    gnome-photos
    gnome.gnome-music
    gnome.gedit
    epiphany
    evince
    gnome.gnome-characters
    gnome.totem
    gnome.tali
    gnome.iagno
    gnome.hitori
    gnome.atomix
    gnome-tour
    gnome.geary
    gnome-text-editor
  ];
  environment.systemPackages = with pkgs; [
    gnome.gnome-tweaks
    gnomeExtensions.vitals

    # These (doesn't work on current Gnome 42)
    # gnomeExtensions.impatience
    # gnomeExtensions.sermon
    # gnomeExtensions.forge
  ];
  hardware.pulseaudio.enable = true;

  services.dbus.packages = with pkgs; [ dconf ];
  programs.dconf.enable = true;

  networking = {
    hostName = "nixos";

    # DNS
    networkmanager = {
      enable = true;
      dns = "none";
      # ethernet.macAddress = "random";
    };

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall = {
      enable = false;
      allowedTCPPorts = [ 33333 ];
      allowedUDPPorts = [ 33333 ];
    };
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
    # registry.nixpkgs.flake = nixpkgs;
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

  boot = {
    cleanTmpDir = true;
    # kernel.sysctl = {
    #   # Wine was suggesting this
    #   "dev.i915.perf_stream_paranoid" = 0;
    # };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };


  # # TODO: Move this to sway module
  # programs.sway = {
  #   enable = true;
  #   wrapperFeatures.gtk = true;
  # };

  # Enable screen sharing in wayland
  # xdg = {
  #   portal = {
  #     enable = true;
  #     extraPortals = with pkgs; [
  #       xdg-desktop-portal-wlr # Sway (wslroots)
  #       xdg-desktop-portal-gtk # Gnome
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
  #security.rtkit.enable = true;
  #services.pipewire = {
  #  enable = true;
  #  alsa.enable = true;
  #  alsa.support32Bit = true;
  #  pulse.enable = true;

  #  # Wireplumber
  #  wireplumber.enable = true;
  #  media-session.enable = false;

  #  # If you want to use JACK applications, uncomment this
  #  #jack.enable = true;
  #};

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "changeme";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
