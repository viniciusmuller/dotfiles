{ pkgs, ... }:

let
  mkLuaCode =
    (
      code:
      ''
        lua << EOF
          ${code}
        EOF
      ''
    );

  gitsigns = {
    plugin = pkgs.vimPlugins.gitsigns-nvim;
    config = ''
        nnoremap <leader>gm <cmd>lua require('gitsigns').blame_line(true)<cr>

        ${mkLuaCode ''
        require('gitsigns').setup{}
      ''}
    '';
  };
in
{
  programs.neovim.plugins = [ gitsigns ];
}
