{ pkgs, prelude, ... }:

let
  lsp_lines = pkgs.vimUtils.buildVimPlugin {
    name = "vim-quickrun";
    version = "2021-07-07";

    src = pkgs.fetchFromSourcehut {
      owner = "~whynothugo";
      repo = "lsp_lines.nvim";
      rev = "db67e94c813aae166c3d2f119ea7d2e85164922a";
      sha256 = "sha256-iAeay6uS2JBRaqxarWZ0Dcqb1RugUPdi7oBexrgE43c=";
    };
  };
  plugin = {
    plugin = lsp_lines;
    config = prelude.mkLuaCode ''
      -- Disable virtual_text since it's redundant due to lsp_lines.
      vim.diagnostic.config({
        virtual_text = false,
      })

      require('lsp_lines').setup()
    '';
  };
in
{
  programs.neovim.plugins = [ plugin ];
}
