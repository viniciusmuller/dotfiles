{ pkgs, ... }:

let
  lfe = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "vim-lfe";
      version = "2021-07-29";

      src = pkgs.fetchFromGitHub {
        owner = "lfe-support";
        repo = "vim-lfe";
        rev = "290e7085fbd53d0c2b98b5d5a442d697c08b7d76";
        sha256 = "sha256-nhitS6E7+ZwqGOL8PxeYPnEZZphtvv2L8qekb7OnxPE=";
      };

      meta.homepage = "https://github.com/lfe-support/vim-lfe";
    };

    config = ''
      autocmd FileType lfe setlocal commentstring=#\|\ %s\ \|#
    '';
  };
in
{
  programs.neovim.plugins = [ lfe ];
}
