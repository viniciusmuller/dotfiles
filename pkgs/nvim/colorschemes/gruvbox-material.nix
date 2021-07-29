{ pkgs, ... }:

let
  gruvbox-material = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "gruvbox-material";
      version = "2021-07-04";

      src = pkgs.fetchFromGitHub {
        owner = "sainnhe";
        repo = "gruvbox-material";
        rev = "5cf1ae0742a24c73f29cbffc308c6f5576404e60";
        sha256 = "0qr9xdvh79wzr00zhqd6zdir1j0xdxw3qq0pqm9d8vxb1k1brzhs";
      };

      meta.homepage = "https://github.com/sainnhe/gruvbox-material";
    };

    config = ''
      set bg=dark
      let g:gruvbox_material_background = 'hard'
      let g:gruvbox_material_enable_italic = 1
      colorscheme gruvbox-material
    '';
  };
in
{
  programs.neovim.plugins = [ gruvbox-material ];
}
