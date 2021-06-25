{ pkgs, ... }:

let
  dwarf-fortress = with pkgs.dwarf-fortress-packages;
    dwarf-fortress-full.override
      (_oldAttrs: rec {
        enableIntro = false;
        enableFPS = true;
      });
in
{
  home.packages = with pkgs; [
    steam
    dwarf-fortress
  ];
}
