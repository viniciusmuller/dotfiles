{ pkgs, ... }:

let
  vim-journal = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "vim-journal";
      version = "2023-04-27";

      src = pkgs.fetchFromGitHub {
        owner = "junegunn";
        repo = "vim-journal";
        rev = "6ab162208dfc8fab479249e4d6a4901be2dabbe8";
        sha256 = "sha256-1WZlvG3N1+wmSWf+PPykrrWuzCpskPX8Dvd1aSCnfz0=";
      };
    };

    config = "";
  };
in
{
  programs.neovim.plugins = [ vim-journal ];
}
