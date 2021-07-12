{ pkgs, ... }:

let
  suckless = import ./repository.nix;
  slock-overlay = (self: super: {
    slock = super.slock.overrideAttrs
      (oldAttrs: rec {
        src = "${suckless}/slock";
        buildInputs = oldAttrs.buildInputs ++ [
          super.xorg.libXinerama
          super.xorg.libXft
        ];
      });
  });
in
{
  nixpkgs.overlays = [ slock-overlay ];
  home.packages = with pkgs; [ slock ];
}
