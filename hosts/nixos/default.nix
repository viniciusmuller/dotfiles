# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos-pkgs/docker.nix
    ./qmk-support.nix

    ../../nixos-pkgs/virt-manager.nix
    ../../nixos-pkgs/steam.nix
    # ../../desktop/xmonad
    # ../../desktop/dwm
    # ../../desktop/hyprland # hyprland is broken

    # Grub
    ../../nixos-pkgs/grub/os-prober.nix
    ../../nixos-pkgs/grub/themes/fallout.nix
  ];

  # environment.variables = {
  #   GTK_IM_MODULE = "cedilla";
  #   QT_IM_MODULE = "cedilla";
  # };

  virtualisation.lxc = {
    enable = true;
    lxcfs.enable = true;
  };

  # hardware.opengl.setLdLibraryPath = true;

  hardware.amdgpu.opencl.enable = true;
  # services.ollama = {
  #   enable = true;
  #   acceleration = "rocm";
  #   rocmOverrideGfx = "10.3.0";
  # };

  services.tailscale.enable = true;

  # services.syncthing = {
  #   enable = true;
  #   user = "vini";
  #   dataDir = "/home/vini/Documents/syncthing/";
  #   configDir = "/home/vini/Documents/.config/syncthing";
  #   openDefaultPorts = true;
  # };

  # https://github.com/swaywm/sway/issues/2773#issuecomment-427570877
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # fileSystems."/mnt/nas-personal" = {
  #   device = "nas:/personal";
  #   fsType = "nfs";
  #   options = [
  #     # Lazy mounting
  #     "x-systemd.automount"
  #     "noauto"
  #     # disconnects after 10 minutes (i.e. 600 seconds)
  #     "x-systemd.idle-timeout=600"
  #   ];
  # };

  # fileSystems."/mnt/autoscape" = {
  #   device = "nas:/autoscape";
  #   fsType = "nfs";
  #   options = [
  #     # Lazy mounting
  #     "x-systemd.automount"
  #     "noauto"
  #     # disconnects after 10 minutes (i.e. 600 seconds)
  #     "x-systemd.idle-timeout=600"
  #   ];
  # };


  # k3s
  # networking.firewall.allowedTCPPorts = [ 6443 ];
  # services.k3s.enable = true;
  # services.k3s.role = "server";
  # services.k3s.extraFlags = toString [
  #   # "--kubelet-arg=v=4" # Optionally add additional args to k3s
  # ];

  documentation.dev.enable = true;

  services.devmon.enable = true;
  services.udisks2.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    # desktopManager.cinnamon.enable = true;
    displayManager.lightdm.enable = true;
    videoDrivers = [ "amdgpu" ];
    xkb.layout = "us";
  };

  services.libinput.enable = true;
  hardware.pulseaudio.enable = false;

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
    firewall.enable = false;

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

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
    ];
    ibus.engines = with pkgs.ibus-engines; [ anthy ];
  };

  services.gvfs.enable = true;

  # Would normally set this to fcitx, but kitty only supports ibus, and fcitx
  # provides an ibus interface. Can't use ibus for e.g. QT_IM_MODULE though,
  # because that at least breaks mumble
  environment.variables.GLFW_IM_MODULE = "ibus";

  ###############################
  ## Input Method Editor (IME) ##
  ###############################

  # i18n.inputMethod.enabled = "ibus";
  # i18n.inputMethod.ibus.engines = with pkgs.ibus-engines; [ libpinyin ];

  # This enables "fcitx" as your IME.  This is an easy-to-use IME.  It supports many different input methods.
  # i18n.inputMethod.enabled = "fcitx5";

  # This enables "mozc" as an input method in "fcitx".  This has a relatively
  # complete dictionary.  I recommend it for Japanese input.
  # i18n.inputMethod.fcitx5.engines = with pkgs; [ fcitx5 ];

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

  users.users.gamer = {
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
