{ pkgs, ... }:

let
  trouble = {
    plugin = pkgs.vimPlugins.trouble-nvim;
    config = ''
      nnoremap tt <cmd>TroubleToggle<cr>
      lua require('trouble').setup{}
    '';
  };
in
{
  programs.neovim.plugins = [ trouble ];
}
