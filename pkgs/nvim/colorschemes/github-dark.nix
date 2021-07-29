
{ pkgs, ... }:

let
  vim-github-dark = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "vim-github-dark";
      version = "2021-07-28";
      src = pkgs.fetchFromGitHub {
        owner = "vv9k";
        repo = "vim-github-dark";
        rev = "c3eca592f8f6ed9fb7c0cebe1ad8be6c63775571";
        sha256 = "1ffyq0pkkr9pbzhwpjf8k5q242mgz9l8zs4i4pgg4nikl5i7j0aw";
      };
      meta.homepage = "https://github.com/vv9k/vim-github-dark";
    };

    config = ''
      colorscheme ghdark
    '';
  };
in
{
  programs.neovim.plugins = [ vim-github-dark ];
}
