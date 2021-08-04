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

  presence = {
    plugin = presence-nvim;
    config = mkLuaCode ''
      require("presence"):setup({
        -- General options
        auto_update         = true,
        neovim_image_text   = "The One True Text Editor",
        main_image          = "file",                   -- Main image display (either "neovim" or "file")
        log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        enable_line_number  = false,                      -- Displays the current line number instead of the current project

        -- Rich Presence text options
        editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer
        file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer
        workspace_text      = "Working on %s",            -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
        line_number_text    = "Line %s out of %s",        -- Line number format string (for when enable_line_number is set to true)
      })
    '';
  };
in
{
  programs.neovim.plugins = [ presence ];
}
