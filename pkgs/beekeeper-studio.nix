{ pkgs, ... }:

let
  # beekeeper-studio-bin = pkgs.fetchurl {
  #   url = "https://github.com/beekeeper-studio/beekeeper-studio/releases/download/v1.12.0/Beekeeper-Studio-1.12.0.AppImage";
  #   sha256 = "jGofvkYCzjEhDeKiC+m+tDHRkmOLAZgof4thhvPUgwQ=";
  # };
  beekeeper-studio = pkgs.fetchFromGithub {
    url = "https://github.com/beekeeper-studio/beekeeper-studio";
    sha256 = "";
  };
  beekeeper-package = mkYarnPackage {
    name = "beekeeper-studio";
    src = beekeeper-studio;
    packageJSON = beekeeper-studio/package.json;
    yarnLock = beekeeper-studio/yarn.lock;
  };
in
{ home.packages = [ beekeeper-package ]; }

# pkgs.stdenv.mkDerivation rec {
#   name = "beekeeper-studio";
#   version = "1.12.0";
#   src = beekeeper-studio-bin;
#   phases = [ "installPhase" ];
#   # TODO: The AppImage will not work, we will need to use
#   # node+yarn and build it from source
#   # https://github.com/beekeeper-studio/beekeeper-studio/blob/master/.github/workflows/sqltools-master.yml
#   installPhase = ''
#     mkdir -p $out/bin
#     cp ${beekeeper-studio-bin} $out/bin/beekeeper-studio
#     chmod +x $out/bin/*
#   '';
# }
