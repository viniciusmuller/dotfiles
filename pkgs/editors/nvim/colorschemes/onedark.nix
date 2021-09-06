{ pkgs, ... }:

let
  onedark = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "my-onedark-nvim";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "navarasu";
        repo = "onedark.nvim";
        rev = "35119a8b264fe9b06ec4245601b7722debb0dd0b";
        sha256 = "sha256-jQHT8UqnRMj0FfXMGfcSijRKA/XPU+tWEb20vznXNRw=";
      };

      meta.homepage = "https://github.com/navarasu/onedark.nvim";
    };
    config = ''
      let g:onedark_disable_toggle_style = 1
      colorscheme onedark
    '';
  };
in
{
  programs.neovim.plugins = [ onedark ];
}
