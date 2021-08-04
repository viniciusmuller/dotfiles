{ pkgs, ... }:

let
  dracula = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "dracula-nvim";
      version = "2021-07-29";

      src = pkgs.fetchFromGitHub {
        owner = "Mofiqul";
        repo = "dracula.nvim";
        rev = "2f98ce06c359fa3f9c34d274615b3f269f89e55c";
        sha256 = "sha256-Zj9Mp7hwBhDr880dQ6RfiSm9xg58tNriwM3DJLKaNr8=";
      };

      meta.homepage = "https://github.com/Mofiqul/dracula.nvim";
    };

    config = ''
      colorscheme dracula
      hi Cursorline guibg=#36394a
      hi ColorColumn guibg=#424763
    '';
  };
in
{
  programs.neovim.plugins = [ dracula ];
}
