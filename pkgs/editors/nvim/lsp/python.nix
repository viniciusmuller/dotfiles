{ pkgs, prelude, ... }:

{
  home.packages = with pkgs; with python39Packages; [
    python39
    python38Packages.python-language-server
    rope
    pyflakes
    pycodestyle # Style linter
    yapf # Formatter
  ];

  programs.neovim.extraConfig = prelude.mkLuaCode ''
    require('lspconfig').pylsp.setup{
      cmd = {'pyls'},
      on_attach = on_attach,
      capabilities = capabilities
    }
  '';
}
