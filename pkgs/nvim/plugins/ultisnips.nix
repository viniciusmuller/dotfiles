{ pkgs, ... }:

let
  ultisnips = {
    plugin = pkgs.vimPlugins.ultisnips;
    config = ''
      let g:UltiSnipsExpandTrigger="<M-j>"
      let g:UltiSnipsJumpForwardTrigger="<C-j>"
      let g:UltiSnipsJumpBackwardTrigger="<C-k>"
    '';
  };
in
{
  programs.neovim.plugins = [
    ultisnips
  ];
}
