{ pkgs, ... }:

let
  git-blame = {
    plugin = pkgs.vimPlugins.git-blame-nvim;
    config = "let g:gitblame_date_format = '%r'";
  };
in
{
  programs.neovim.plugins = [ git-blame ];
}
