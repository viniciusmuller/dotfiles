{ pkgs, ... }:

let
  vscode = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "vscode-nvim";
      version = "2021-07-29";

      src = pkgs.fetchFromGitHub {
        owner = "Mofiqul";
        repo = "vscode.nvim";
        rev = "fca44117193b4b1dddf0df65214285295efbfb2d";
        sha256 = "sha256-tuUfzORxWumwP2xmjW0Y9SbQwthXfQ9wf9HvezczOo4=";
      };

      meta.homepage = "https://github.com/Mofiqul/vscode.nvim";
    };

    config = ''
      " hi Cursorline guibg=#36394a
      " hi ColorColumn guibg=#424763
      let g:vscode_style = "dark"
      colorscheme vscode
    '';
  };
in
{
  programs.neovim.plugins = [ vscode ];
}
