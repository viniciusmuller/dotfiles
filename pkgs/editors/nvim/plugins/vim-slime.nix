{ pkgs, ... }:

let
  vim-slime = {
    plugin = pkgs.vimPlugins.vim-slime;
    config = ''
      let g:slime_target = "tmux"
      let g:slime_paste_file = tempname()
      let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
    '';
  };
in
{
  programs.neovim.plugins = [ vim-slime ];
}
