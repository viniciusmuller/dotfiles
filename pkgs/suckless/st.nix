{ pkgs, ... }:

let
  # TODO: Create a function to make custom suckless packages
  suckless = import ./repository.nix;
  st-overlay = (self: super: {
    st = prev.st.overrideAttrs (old: rec {
      buildInputs = old.buildInputs ++ [ prev.harfbuzz ];
      src = "${suckless}/st";
    });
  });
in
{
  nixpkgs.overlays = [ st-overlay ];
  home.packages = with pkgs; [ st ];
}
