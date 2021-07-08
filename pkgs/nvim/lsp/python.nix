{ pkgs, ... }:


let
  mkLuaCode =
    (code:
      ''
        lua << EOF
          ${code}
        EOF
      '');
in
{
  home.packages = with pkgs; [
    python38Packages.python-language-server
    python38Packages.rope
    python38Packages.pyflakes
    python38Packages.pycodestyle
    yapf
  ];

  # TODO: Make a prelude with these helper functions
  programs.neovim.extraConfig = mkLuaCode ''
    require('lspconfig').pyls.setup{
      on_attach = on_attach
    }
  '';
}
