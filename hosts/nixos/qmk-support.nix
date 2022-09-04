{ pkgs, ... }:

{
  # Note that one still need to get a dev shell containing the qmk package
  services.udev.packages = [
    pkgs.qmk-udev-rules
  ];
}
