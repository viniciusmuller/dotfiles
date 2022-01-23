{ pkgs, prelude, ... }:

let
  nvim-lint = {
    plugin = pkgs.vimPlugins.nvim-lint;
    config = ''
      ${prelude.mkLuaCode ''
        require('lint').linters_by_ft = {
          go = {'golangcilint',}
        }
      ''}

      " TODO: Autocommands not working (but they work if manually pasted into vim's CLI)
      augroup nvim_lint
        " au BufWritePost <buffer> lua require('lint').try_lint()
        " au InsertLeave <buffer> lua require('lint').try_lint()
      augroup end
    '';
  };
in
{
  programs.neovim.plugins = [ nvim-lint ];
}


