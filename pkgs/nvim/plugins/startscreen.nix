{ pkgs, ... }:

let
  startscreen = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "startscreen-nvim";
      version = "2021-08-02";

      src = pkgs.fetchFromGitHub {
        owner = "arp242";
        repo = "startscreen.vim";
        rev = "90bf116b3adb78a635be101193f98b1e99164af9";
        sha256 = "sha256-UhFU8Bw2NdodTfTaP1VIJ37hAavY5LrN4VIM0XX0y94=";
      };

      meta.homepage = "https://github.com/arp242/startscreen.vim";
    };

    config = ''
      function! T()
        let message =<< trim END
          ██████   ██████  ██████   █████
          ██   ██ ██    ██ ██   ██ ██   ██
          ██████  ██    ██ ██████  ███████
          ██   ██ ██    ██ ██   ██ ██   ██
          ██████   ██████  ██   ██ ██   ██

          ███    ███  ██████  ███    ██ ███████ ████████ ██████   █████   ██████
          ████  ████ ██    ██ ████   ██ ██         ██    ██   ██ ██   ██ ██    ██
          ██ ████ ██ ██    ██ ██ ██  ██ ███████    ██    ██████  ███████ ██    ██
          ██  ██  ██ ██    ██ ██  ██ ██      ██    ██    ██   ██ ██   ██ ██    ██
          ██      ██  ██████  ██   ████ ███████    ██    ██   ██ ██   ██  ██████
        END

        setlocal modifiable
        put =message
        :%>>>
        normal gg0
        setlocal nomodifiable
      endfun

      let g:Startscreen_function = function('T')
    '';
  };
in
{
  programs.neovim.plugins = [ startscreen ];
}
