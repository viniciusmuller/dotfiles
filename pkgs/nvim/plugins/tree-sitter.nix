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

  treesitter = {
    plugin = pkgs.vimPlugins.nvim-treesitter;
    config = mkLuaCode ''
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
    '';
  };

  treesitter-textobjects = pkgs.vimPlugins.nvim-treesitter-textobjects;
in
{
  programs.neovim.plugins = [
    treesitter
    treesitter-textobjects
  ];
}
