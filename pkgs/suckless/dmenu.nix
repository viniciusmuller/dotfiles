{ pkgs, ... }:

let
  # TODO: Create a function to make custom suckless packages
  suckless = import ./repository.nix;
  dmenu-overlay = (self: super: {
    dmenu = super.dmenu.overrideAttrs
      (_oldAttrs: rec {
        src = "${suckless}/dmenu";
      });
  });
in
{
  nixpkgs.overlays = [ dmenu-overlay ];
  home.packages = with pkgs; [ dmenu ];
}
