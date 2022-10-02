{ pkgs, prelude, ... }:

let
  custom-treesitter = (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars));
  treesitter = {
    plugin = custom-treesitter;
    config = prelude.mkLuaCode ''
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
            },
          },
        }
      }

      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
    '';
  };

  ts-textobjects = pkgs.vimPlugins.nvim-treesitter-textobjects;
in
{
  programs.neovim.plugins = [
    treesitter
    ts-textobjects
  ];
}
