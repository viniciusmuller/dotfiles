{ pkgs, ... }:

{
  boot = {
    loader = {
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        devices = [ "nodev" ];
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}
