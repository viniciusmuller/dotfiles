{ pkgs, prelude, ... }:

{
  home.packages = with pkgs; [
    rnix-lsp
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').rnix.setup{
      on_attach = on_attach
    }
  '';
}
