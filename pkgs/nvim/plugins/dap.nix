
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

  dap = {
    plugin = pkgs.vimPlugins.nvim-dap;
    config = ''
      nnoremap <leader>dd <cmd>lua require('dap').toggle_breakpoint()<cr>
      nnoremap <leader>dD <cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>
      nnoremap <leader>df :lua require('dap').continue()<cr>
      nnoremap <leader>dj <cmd>lua require('dap').step_out()<cr>
      nnoremap <leader>dk <cmd>lua require('dap').step_into()<cr>
      nnoremap <leader>dl <cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>
      nnoremap <leader>dr <cmd>lua require('dap').repl.open()<cr>

      ${mkLuaCode ''
      -- require('dap.ext.vscode').load_launchjs()

      local dap = require('dap')

      dap.configurations.python = {
        {
          type = 'python';
          request = 'launch';
          name = "Launch file";
          program = "''${fileDirname}";
        },
      }

      dap.adapters.python = {
        type = 'executable';
        command = 'python';
        args = { '-m', 'debugpy.adapter' };
      }
    ''}
    '';
  };
in
{
  programs.neovim.plugins = [ dap ];
}
