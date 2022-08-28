{ pkgs, prelude, ... }:

let
  parsers = pkgs.tree-sitter.withPlugins (plugins:
    with plugins; [
      tree-sitter-bash
      tree-sitter-bibtex
      tree-sitter-latex
      tree-sitter-comment
      tree-sitter-css
      tree-sitter-go
      tree-sitter-html
      tree-sitter-javascript
      tree-sitter-json
      tree-sitter-lua
      tree-sitter-make
      tree-sitter-markdown
      tree-sitter-nix
      tree-sitter-python
      tree-sitter-regex
      tree-sitter-rust
      tree-sitter-scss
      tree-sitter-toml
      tree-sitter-typescript
      tree-sitter-vim
      tree-sitter-yaml
      tree-sitter-elixir
  ]);
  treesitter = {
    plugin = pkgs.vimPlugins.nvim-treesitter;
    config = prelude.mkLuaCode ''
      vim.opt.runtimepath:append("${parsers}")

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

  home.packages = with pkgs; [ tree-sitter gcc ];
}
