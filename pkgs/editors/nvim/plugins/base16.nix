{ pkgs, ... }:

let
  base16-vim = {
    plugin = pkgs.vimPlugins.base16-vim;
    config = ''
      let base16colorspace=256  " Access colors present in 256 colorspace
      set termguicolors
    '';
  };
in
{
  programs.neovim.plugins = [ base16-vim ];
}
