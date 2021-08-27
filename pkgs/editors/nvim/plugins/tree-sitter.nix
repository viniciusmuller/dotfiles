{ pkgs, prelude, ... }:

let
  treesitter = {
    plugin = pkgs.vimPlugins.nvim-treesitter;
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

      vim.cmd[[highlight link TSError Normal]]
      vim.cmd[[highlight link TSNote Normal]]
      vim.cmd[[highlight link TSWarning Normal]]
    '';
  };

  ts-textobjects = pkgs.vimPlugins.nvim-treesitter-textobjects;
in
{
  programs.neovim.plugins = [
    treesitter
    ts-textobjects
  ];

  home.packages = with pkgs; [ tree-sitter gcc ];
}
