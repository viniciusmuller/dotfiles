{ pkgs, ... }:

let
  dwarf-fortress = with pkgs.dwarf-fortress-packages;
    dwarf-fortress-full.override
      (_oldAttrs: rec {
        enableSound = false;
        enableIntro = false;
        enableTWBT = true;
        enableFPS = true;
      });
in
{
  home.packages = [ dwarf-fortress ];
}
