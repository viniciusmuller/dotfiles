# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos-pkgs/docker.nix
    ./qmk-support.nix

    # ../../nixos-pkgs/virt-manager.nix
    ../../nixos-pkgs/steam.nix
    ../../desktop/xmonad

    # Grub
    ../../nixos-pkgs/grub/os-prober.nix
  ];

  environment.variables = {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };

  hardware.opengl.setLdLibraryPath = true;

  # https://github.com/swaywm/sway/issues/2773#issuecomment-427570877
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  fileSystems."/mnt/nas-personal" = {
    device = "nas:/personal";
    fsType = "nfs";
    options = [
      # Lazy mounting
      "x-systemd.automount"
      "noauto"
      # disconnects after 10 minutes (i.e. 600 seconds)
      "x-systemd.idle-timeout=600"
    ];
  };

  services.devmon.enable = true;
  services.udisks2.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    libinput.enable = true;
    videoDrivers = [ "amdgpu" ];
    layout = "us";
  };
  programs.hyprland.enable = true;

  services.dbus.packages = with pkgs; [ dconf ];
  programs.dconf.enable = true;
  programs.noisetorch.enable = true;

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
    "resolv.conf".text = "nameserver 192.168.2.1\n";
  };

  nix = {
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
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];
    initrd.kernelModules = [ "amdgpu" ];
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Audio with pipewire
  #security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Wireplumber
    wireplumber.enable = true;

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

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
