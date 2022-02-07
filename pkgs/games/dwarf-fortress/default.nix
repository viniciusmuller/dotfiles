{ pkgs, lib, ... }:

let
  dwarf-fortress = with pkgs.dwarf-fortress-packages;
    dwarf-fortress-full.override
      (_oldAttrs: rec {
        enableSound = false;
        enableIntro = false;
        enableTWBT = true;
        enableFPS = true;
        # Apparently cool tilesets that can't be enabled right now:
        # Nagidal's classic 24x24
        # Taywee Hack Square 64x64
        theme = "gemset";
      });
  # Maybe enable someday: autohauler stockflow workflow dwarfvet

  dfhack = pkgs.stdenv.mkDerivation rec {
    name = "dfhack";
    version = "0.47.05-r3";
    sourceRoot = "hack";
    dontBuild = true;
    src = pkgs.fetchurl {
      url = "https://github.com/DFHack/dfhack/releases/download/${version}/dfhack-${version}-Linux-64bit-gcc-7.tar.bz2";
      sha256 = "sha256-ZUUas6hRED4fZMratGuh5cIRDTjhulJjOfhbWrDszeY=";
    };
    installPhase = ''
      mkdir -p $out/lib
      mv libdfhack.so $out/lib
    '';
    nativeBuildInputs = [ pkgs.bzip2 ];
  };

  armok-vision = pkgs.stdenv.mkDerivation rec {
    pname = "armok-vision";
    version = "0.21.0";
    sourceRoot = ".";
    src = pkgs.fetchurl {
      url = "https://github.com/RosaryMala/armok-vision/releases/download/v${version}/Armok.Vision.${version}.Linux.zip";
      sha256 = "sha256-T8RoZPomheFSI1Mfjz3S3puKkyfwk4RhOQzq4SKlXQs=";
    };
    installPhase = ''
      mkdir -p $out/share/armok $out/bin $out/lib
      mv *.so $out/lib
      mv "Armok Vision Linux_Data" $out/share/armok

      chmod +x "Armok Vision Linux.x86_64"
      cp "Armok Vision Linux.x86_64" $out/bin/armok-vision
    '';
    buildInputs = with pkgs; [
      dfhack
      protobuf
      stdenv.cc.cc
      SDL
    ];
    nativeBuildInputs = [
      pkgs.autoPatchelfHook
      pkgs.unzip
    ];
  };
in
{
  home.packages = [
    dwarf-fortress
    # armok-vision # TODO: Armok Vision gives weird runtime error
  ];
  xdg.dataFile."df_linux/dfhack.init".source = ./dfhack.init;
  # xdg.dataFile."df_linux/data/init/colors.txt".source = ./colors.txt;

  # TODO: Make PR to nixpkgs that add flags that I need (population cap, etc)
  # This way it's not working
  # xdg.dataFile."df_linux/data/init/d_init.txt".source = ./d_init.txt;
}
