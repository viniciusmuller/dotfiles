{ pkgs, prelude, ... }:

let
  session-manager = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "neovim-session-manager";
      version = "2022-01-08";
      src = pkgs.fetchFromGitHub {
        owner = "Shatur";
        repo = "neovim-session-manager";
        rev = "bff80bee884d7f728dd1030d7639a422475d5269";
        sha256 = "sha256-2DswlA71s7EUAb8dDGwGsAaH23ietbOi4o0QMz3p6Lg=";
      };
      meta.homepage = "https://github.com/Shatur/neovim-session-manager";
    };

    config = prelude.mkLuaCode ''
      local Path = require('plenary.path')

      require('session_manager').setup({
        sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'), -- The directory where the session files will be saved.
        path_replacer = '__', -- The character to which the path separator will be replaced for session files.
        colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.

        -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,

        autosave_last_session = true, -- Automatically save last session on exit.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no writable and listed buffers are opened.
        autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
      })
      -- require('telescope').load_extension('sessions')
    '';
  };
in
{
  programs.neovim.plugins = [
    session-manager
    pkgs.vimPlugins.plenary-nvim
    # pkgs.vimPlugins.telescope-nvim
  ];
}
