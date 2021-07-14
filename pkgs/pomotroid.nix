{ pkgs, ... }:

let
  pomotroid = pkgs.appimageTools.wrapType2 {
    name = "pomotroid";
    src = pkgs.fetchurl {
      url = "https://github.com/Splode/pomotroid/releases/download/v0.13.0/pomotroid-0.13.0-linux.AppImage";
      sha256 = "kRXOG4aFj+13G4Ri15mXRj+CWm92BfXfmS5KNPSDZgY=";
    };
  };
in
{
  home.packages = [ pomotroid ];
}
