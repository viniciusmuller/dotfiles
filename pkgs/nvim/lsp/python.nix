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
in
{
  home.packages = with pkgs; with python39Packages; [
    python39
    python38Packages.python-language-server
    rope
    pyflakes
    pycodestyle # Style linter
    yapf # Formatter
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = mkLuaCode ''
    require('lspconfig').pylsp.setup{
      cmd = {'pyls'},
      on_attach = on_attach
    }
  '';
}
