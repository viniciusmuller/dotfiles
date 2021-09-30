{ config, pkgs, prelude, ... }:

with pkgs.vimPlugins;
let
  nvim-spell-pt = builtins.fetchurl {
    url =
      "https://github.com/mateusbraga/vim-spell-pt-br/raw/3d7eb3098de77b86c8a880354b442b3d84b18a72/spell/pt.utf-8.spl";
    sha256 = "01zqss1fsc2rhaqhi10364qxyc64n2ndkn9d6rql20j3jvzbrlmd";
  };

  aliases = {
    v = "nvim";
    nv = "nvim";
  };
in
{
  imports = [
    # ---- Language server protocol ----
    ./plugins/lsp-signature.nix
    ./plugins/lspconfig.nix
    ./plugins/lsp-extensions.nix

    ./lsp/omnisharp.nix
    ./lsp/go.nix
    ./lsp/rust.nix
    # ./lsp/clojure.nix
    ./lsp/elixir.nix
    # ./lsp/godot.nix
    # ./lsp/haskell.nix
    # ./lsp/latex.nix
    # ./lsp/lua.nix
    ./lsp/node.nix
    # ./lsp/python.nix
    ./lsp/rnix.nix
    ./lsp/ccls.nix

    # ---- Development profiles ----
    ./profiles/web.nix

    # ---- Language specific ----
    ./languages/vim-go.nix
    ./languages/rust-vim.nix

    # ---- General plugins ----

    # Utils
    # ./plugins/tree-sitter.nix
    ./plugins/nvim-tree.nix
    ./plugins/cmp.nix
    ./plugins/pears.nix

    ./plugins/fzf.nix

    ./plugins/vim-test.nix
    ./plugins/togglelist.nix
    ./plugins/closetag.nix
    ./plugins/slash.nix
    # ./plugins/neomake.nix

    # Repl
    ./plugins/conjure.nix

    # Debugging
    # ./plugins/dap.nix
    # ./plugins/dap-ui.nix

    # Git
    ./plugins/gitsigns.nix
    # ./plugins/fugitive.nix
    # ./plugins/git-blame.nix

    # Aesthetic
    ./colorschemes/tokyonight.nix
    ./plugins/lualine.nix
    ./plugins/bufferline.nix
    ./plugins/colorizer.nix
    # ./plugins/rainbow.nix
  ];

  xdg.configFile."nvim/spell/pt.utf-8.spl".source = nvim-spell-pt;

  programs.neovim = {
    enable = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      vim-polyglot
      nvim-web-devicons
      targets-vim
      vim-commentary
      vim-repeat
      vim-sensible
      vim-surround
      undotree
      vim-vsnip
      friendly-snippets
      vim-tmux-navigator
    ];

    initExtra = ''
      let mapleader = " "
      let maplocalleader = ","
    '';

    extraConfig = builtins.readFile ./init.vim;
  };

  # inherit (prelude.mkShellAlias aliases);
  programs.bash.shellAliases = aliases;
  programs.zsh.shellAliases = aliases;
  programs.fish.shellAliases = aliases;
}
