{ pkgs, lib, ... }:

let
  dwarf-fortress = with pkgs.dwarf-fortress-packages;
    dwarf-fortress-full.override
      (_oldAttrs: rec {
        enableSound = false;
        enableSoundSense = false;
        enableIntro = false;
        enableTWBT = false;
        enableFPS = false;
        enableDFHack = false;
        theme = null;
      });
in
{
  # TODO: Setup custom colors and init files 
  home.packages = [ dwarf-fortress ];

  # xdg.dataFile."df_linux/dfhack.init".source = ./dfhack.init;

  # xdg.configHome.".dwarf-fortress/df_linux/data/init/colors.txt".source = ./colors.txt;
  # xdg.configHome.".dwarf-fortress/df_linux/data/init/d_init.txt".source = ./d_init.txt;
  # xdg.configHome.".dwarf-fortress/df_linux/data/init/init.txt".source = ./init.txt;
}
