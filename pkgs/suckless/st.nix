{ pkgs, ... }:

let
  # TODO: Create a function to make custom suckless packages
  suckless = import ./repository.nix;
  st-overlay = (self: super: {
    st = super.st.overrideAttrs (old: rec {
      buildInputs = old.buildInputs ++ [ super.harfbuzz ];
      src = "${suckless}/st";
    });
  });
in
{
  nixpkgs.overlays = [ st-overlay ];
  home.packages = with pkgs; [ st ];
}
