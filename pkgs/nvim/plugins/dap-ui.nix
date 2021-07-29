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

  dap-ui = {
    plugin = pkgs.vimPlugins.nvim-dap-ui;
    config = ''
      nnoremap <leader>du <cmd>lua require('dapui').toggle()<cr>

      augroup dap_ui
        au FileType dap-repl lua require('dap.ext.autocompl').attach()
        au BufEnter * :call SetDAPColors()
      augroup end

      function! SetDAPColors()
        hi default link DapUIVariable Normal
        hi default link DapUIScope Function
        hi default link DapUIDecoration Function
        hi default link DapUIType Type
        hi default link DapUISource Statement
        hi default link DapUILineNumber Constant
        hi default link DapUIFrameName Normal
        hi default link DapUIBreakpointsPath Function

        " Highlights below might change

        hi default link DapUIStoppedThread Function
        hi default link DapUIThread Function
        hi default link DapUIWatchesFrame Function
        hi default link DapUIWatchesHeader Function

        " hi default DapUIWatchesError guifg=#F70067
        hi default link DapUIWatchesError Error
        " hi default DapUIWatchesEmpty guifg=#F70067
        hi default link DapUIWatchesEmpty Error

        hi default DapUIFloatBorder guifg=#00F1F5
        hi default DapUIWatchesValue guifg=#A9FF68
        hi default DapUIBreakpointsInfo guifg=#A9FF68
        hi default DapUIBreakpointsCurrentLine guifg=#A9FF68 gui=bold

        hi default link DapUIBreakpointsLine DapUILineNumber
      endfunction

      ${mkLuaCode ''
      require('dapui').setup({
        icons = {
          expanded = "▾",
          collapsed = "▸"
        },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>" },
          open = "o",
          remove = "d",
          edit = "e",
        },
        sidebar = {
          open_on_start = true,
          elements = {
            -- You can change the order of elements in the sidebar
            "scopes",
            "breakpoints",
            "stacks",
            "watches"
          },
          width = 40,
          position = "left" -- Can be "left" or "right"
        },
        tray = {
          open_on_start = true,
          elements = {
            "repl"
          },
          height = 10,
          position = "bottom" -- Can be "bottom" or "top"
        },
        floating = {
          max_height = nil, -- These can be integers or a float between 0 and 1.
          max_width = nil   -- Floats will be treated as percentage of your screen.
        }
      })
    ''}
    '';
  };
in
{
  programs.neovim.plugins = [ dap-ui ];
}
