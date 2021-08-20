{ pkgs, ... }:

let
  pomatez = pkgs.appimageTools.wrapType2 {
    name = "pomatez";
    src = pkgs.fetchurl {
      url = "https://github.com/roldanjr/pomatez/releases/download/v1.1.0/Pomatez-v1.1.0-linux.AppImage";
      sha256 = "sha256-58WMHcylS7JujTwJ2zpJ5gzxU50PVWpo085vQFKdJYs=";
    };
  };
in
{
  home.packages = [ pomatez ];
}
