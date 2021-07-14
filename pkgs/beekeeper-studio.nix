{ pkgs, ... }:

let
  beekeeper-studio = pkgs.appimageTools.wrapType2 {
    name = "beekeeper-studio";
    src = pkgs.fetchurl {
      url = "https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v1.12.0/Beekeeper-Studio-1.12.0.AppImage";
      sha256 = "sha256-jGofvkYCzjEhDeKiC+m+tDHRkmOLAZgof4thhvPUgwQ=";
    };
  };
in
{
  home.packages = [ beekeeper-studio ];
}
