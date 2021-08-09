{ pkgs, ... }:

let
  github-dark = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "github-nvim-theme";
      version = "2021-07-28";
      src = pkgs.fetchFromGitHub {
        owner = "projekt0n";
        repo = "github-nvim-theme";
        rev = "347b2938906647ee75fe9bacf46f6d5488c250ac";
        sha256 = "sha256-xZrR8n2Hhqz4HwXtvZuvbR7eI/o4A8TvKLBdEKxIoMA=";
      };
      meta.homepage = "https://github.com/projekt0n/github-nvim-theme";

      postPatch = "rm Makefile";
    };

    config = "lua require('github-theme').setup()";
  };
in
{
  programs.neovim.plugins = [ github-dark ];
}
