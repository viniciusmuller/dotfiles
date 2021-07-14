{ pkgs, ... }:

let
  # TODO: Create a function to make custom suckless packages
  suckless = import ./repository.nix;
  dwm-overlay = (self: super: {
    dwm = super.dwm.overrideAttrs
      (_oldAttrs: rec {
        src = "${suckless}/dwm";
      });
  });
in
{
  nixpkgs.overlays = [ dwm-overlay ];
  home.packages = with pkgs; [ dwm ];
}
