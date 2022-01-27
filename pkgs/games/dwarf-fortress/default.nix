{ pkgs, ... }:

let
  dwarf-fortress = with pkgs.dwarf-fortress-packages;
    dwarf-fortress-full.override
      (_oldAttrs: rec {
        enableSound = false;
        enableIntro = false;
        enableTWBT = true;
        enableFPS = true;
        theme = null;
      });
  # Maybe enable someday: autohauler stockflow workflow dwarfvet
  # TODO: make this build
  armok-vision = pkgs.stdenv.mkDerivation rec {
    pname = "armok-vision";
    version = "0.21.0";
    src = pkgs.fetchurl {
      url = "https://github.com/RosaryMala/armok-vision/releases/download/v${version}/Armok.Vision.${version}.Linux.zip";
      sha256 = "sha256-T8RoZPomheFSI1Mfjz3S3puKkyfwk4RhOQzq4SKlXQs=";
    };
    # unpackPhase = ''
    #   ${pkgs.unzip}/bin/unzip Armok.Vision.${version}.Linux.zip
    # '';
    installPhase = ''
      mkdir -p $out/bin
      chmod +x "Armok Vision Linux.x86_64"
      ln -s "Armok Vision Linux.x86_64" $out/bin/armok-vision
    '';
    nativeBuildInputs = [
      pkgs.autoPatchelfHook
      pkgs.unzip
    ];
  };
in
{
  home.packages = [
    dwarf-fortress
    # armok-vision
  ];
  xdg.dataFile."df_linux/dfhack.init".source = ./dfhack.init;
  # xdg.dataFile."df_linux/data/init/colors.txt".source = ./colors.txt;

  # TODO: Make PR to nixpkgs that add flags that I need (population cap, etc)
  # This way it's not working
  # xdg.dataFile."df_linux/data/init/d_init.txt".source = ./d_init.txt;
}
