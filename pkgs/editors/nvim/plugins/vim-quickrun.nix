{ pkgs, ... }:

let
  quickrun = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "vim-quickrun";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "thinca";
        repo = "vim-quickrun";
        rev = "581b44800dddd01b69669257787e05ccbb6a21cc";
        sha256 = "LZMJhJ0A3tLn1g8SbCePWbiwqHtafLvDPvMGkhzYvzQ=";
      };

      meta.homepage = "https://github.com/thinca/vim-quickrun";
    };

    config = "nnoremap <leader>qr <cmd>QuickRun<cr>";
  };
in
{
  programs.neovim.plugins = [ quickrun ];
}

