{ pkgs, lib, ... }:

let
  # dwarf-fortress = with pkgs.dwarf-fortress-packages;
    # dwarf-fortress-full.override
    #   (_oldAttrs: rec {
    #     enableSound = false;
    #     enableSoundSense = false;
    #     enableIntro = false;
    #     enableTWBT = true;
    #     enableFPS = true;
    #     # Apparently cool tilesets that can't be enabled right now:
    #     # Nagidal's classic 24x24
    #     # Taywee Hack Square 64x64
    #     # theme = pkgs.dwarf-fortress-packages.themes.spacefox;
    #     theme = null;
    #   });
  # Maybe enable someday: autohauler stockflow workflow dwarfvet
in
{
  home.packages = with pkgs; [
    dwarf-fortress 
    dwarf-fortress-packages.dwarf-therapist
    dwarf-fortress-packages.legends-browser
  ];
  # xdg.dataFile."df_linux/dfhack.init".source = ./dfhack.init;
  xdg.dataFile."df_linux/data/init/colors.txt".source = ./colors.txt;
  xdg.dataFile."df_linux/data/init/d_init.txt".source = ./d_init.txt;
  xdg.dataFile."df_linux/data/init/init.txt".source = ./init.txt;
}
