{ pkgs, prelude, ... }:

let
  neorg = {
    plugin = pkgs.vimPlugins.neorg;
    config = prelude.mkLuaCode ''
        require('neorg').setup {
          -- Tell Neorg what modules to load
          load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.keybinds"] = {
              config = {
                default_keybinds = true,
                norg_leader = "<leader>o"
              }
            }, -- Load keybinds
            ["core.norg.concealer"] = {}, -- Allows for use of icons
            ["core.norg.dirman"] = { -- Manage your directories with Neorg
            config = {
              workspaces = {
                my_workspace = "~/.neorg"
              }
            }
          }
        },
      }
    '';
  };
in
{
  programs.neovim.plugins = [ neorg ];
}
