{ pkgs, ... }:

let
  yomininja = pkgs.appimageTools.wrapType2 {
    name = "yomininja";
    src = pkgs.fetchurl {
      url = "https://github.com/matt-m-o/YomiNinja/releases/download/v0.7.2/YomiNinja-0.7.2.AppImage";
      sha256 = "sha256-icxRiZrxM79nuUqcXYOJDphP77TR7qTJ4oKNDpl1Z3E=";
    };
  };
in
{
  home.packages = [ yomininja ];
}
