{ pkgs, ... }:

let
  neomake = {
    plugin = pkgs.vimPlugins.neomake;
    config = ''
      call neomake#configure#automake('nrwi', 500)
    '';
  };
in
{
  programs.neovim.plugins = [ neomake ];
}
