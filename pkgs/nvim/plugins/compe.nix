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

  compe = {
    plugin = pkgs.vimPlugins.nvim-compe;
    config = ''
      " Keybindings
      inoremap <silent><expr> <C-space> compe#complete()
      " inoremap <silent><expr> <cr>      compe#confirm('<CR>')
      " inoremap <silent><expr> <CR>      compe#confirm(luaeval("require 'nvim-autopairs'.autopairs_cr()"))
      inoremap <silent><expr> <C-e>     compe#close('<C-e>')
      inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
      inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

      inoremap <silent><expr> <tab> pumvisible() ? "\<C-n>" : "\<tab>"
      inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<C-h>"

      ${mkLuaCode ''
      require('compe').setup {
        enabled = true;
        autocomplete = true;
        debug = false;
        min_length = 1;
        preselect = 'always';
        throttle_time = 80;
        max_abbr_width = 100;
        max_kind_width = 100;
        max_menu_width = 100;
        documentation = true;

        source = {
          emoji = true;
          path = true;
          buffer = true;
          calc = true;
          spell = true;
          nvim_lsp = true;
          nvim_lua = true;
          ultisnips = true;
          luasnip = true;
        };
      }
    ''}
    '';
  };
in
{
  programs.neovim.plugins = [ compe ];
}
