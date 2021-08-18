{ pkgs, ... }:

let
  lfe = {
    plugin = pkgs.vimPlugins.vim-lfe;
    config = ''
      autocmd FileType lfe setlocal commentstring=#\|\ %s\ \|#
    '';
  };
in
{
  programs.neovim.plugins = [ lfe ];
}
