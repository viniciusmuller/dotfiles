# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ../../nixos-pkgs/virtualbox.nix
      ../../nixos-pkgs/manpages.nix
      ../../nixos-pkgs/docker.nix
      ../../nixos-pkgs/steam.nix
      ../../nixos-pkgs/slock.nix
      ../../nixos-pkgs/zsh.nix
      ../../nixos-pkgs/kmonad
    ];

  nix = {
    # TODO: Find better place for this
    package = pkgs.nixUnstable;
    extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
      "experimental-features = nix-command flakes";

    gc = {
      automatic = true;
      options = "--delete-older-than 2d";
    };

    autoOptimiseStore = true;
  };

  fonts.fontconfig.enable = true;
  fonts.fonts = with pkgs; [
    # TODO: Create file for fonts #
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.emacs-all-the-icons-fonts
  ];

  home-manager.users.vini = import ./home.nix;

  # Boot
  boot = {
    loader = {
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        devices = [ "nodev" ];
        # set $FS_UUID to the UUID of the EFI partition
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 8244F75D44F75301
            # chainloader /EFI/Microsoft/Boot/bootmgfw.efi
            chainloader /Windows/System32/bootmgfw.efi
          }

          # menuentry "Windows" {
          #   insmod part_gpt
          #   insmod fat
          #   insmod search_fs_uuid
          #   insmod chain

          #   # drivemap -s (hd0) (hd1)
          #   # search.fs_uuid --no-floppy --set=root 61a6db12-f49f-4537-834a-d1caf5326f55

          #   set root='(hd1,0)'
          #   chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          # }

          # menuentry "Windows 10 (on /dev/sdb2)" {
          #    insmod ntfs
          #    set root='(hd1,1)'
          #    search --no-floppy --fs-uuid --set 61a6db12-f49f-4537-834a-d1caf5326f55
          #    chainloader /Windows/System32/winload.efi
          # }
        '';
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };

    supportedFilesystems = [ "ntfs" ];
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

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.dwm.enable = true;
  };

  # Configure keymap in X11
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  nixpkgs.config.allowUnfree = true;

  # Audio
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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vini = {
    isNormalUser = true;
    # Enable ‘sudo’ for the user.
    extraGroups = [ "wheel" ];
    # TODO: Add default password
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}