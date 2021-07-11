{ pkgs, ... }:

with pkgs;
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
  # TODO: Make a prelude with these helper functions
  programs.neovim = {
    extraConfig = mkLuaCode ''
      require('lspconfig').gdscript.setup{
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 150,
        }
      }
    '';
  };
}
