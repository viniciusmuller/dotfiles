{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    steam
    # TODO: Figure out how to customize this package (maybe overlay?)
    dwarf-fortress-packages.dwarf-fortress-full
  ];
}
