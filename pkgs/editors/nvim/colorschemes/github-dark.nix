{ pkgs, ... }:

let
  github-dark = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "github-nvim-theme";
      version = "2022-04-24";
      src = pkgs.fetchFromGitHub {
        owner = "projekt0n";
        repo = "github-nvim-theme";
        rev = "9c641bde299ceb373b014a18eb5547fb4e9b57e6";
        sha256 = "sha256-4WTV/T9eiQ8cmwSwK+Oyflry9qVNXDlDHvTQGx45bf4=";
      };
      meta.homepage = "https://github.com/projekt0n/github-nvim-theme";

      postPatch = "rm Makefile";
    };

    config = ''
      lua require('github-theme').setup({ theme_style = "dark_default", })
      hi! link Statusline Text
    '';
  };
in
{
  programs.neovim.plugins = [ github-dark ];
}
