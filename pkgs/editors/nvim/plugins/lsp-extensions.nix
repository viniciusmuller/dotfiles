{ pkgs, ... }:

let
  lsp-extensions = {
    plugin = pkgs.vimPlugins.lsp_extensions-nvim;
    config = ''
      function MyInlayHints()
        lua require('lsp_extensions').inlay_hints{ prefix = ' » ', enabled = {"ChainingHint", "TypeHint", "ParameterHint"} }
      endfunction

      augroup lsp_extension
        autocmd InsertLeave,TextChanged,BufRead *.rs call MyInlayHints()
      augroup end
    '';
  };
in
{
  programs.neovim.plugins = [ lsp-extensions ];
}
