{ pkgs, ... }:

let
  # TODO: Create a function to make custom suckless packages
  suckless = import ./repository.nix;
  slstatus-overlay = (self: super: {
    slstatus = super.slstatus.overrideAttrs
      (_oldAttrs: rec {
        src = "${suckless}/slstatus";
      });
  });
in
{
  nixpkgs.overlays = [ slstatus-overlay ];
  home.packages = with pkgs; [ slstatus ];
}
