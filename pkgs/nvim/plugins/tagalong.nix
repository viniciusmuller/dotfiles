{ pkgs, ... }:

let
  tagalong = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "tagalong.vim";
      version = "2021-08-02";

      src = pkgs.fetchFromGitHub {
        owner = "AndrewRadev";
        repo = "tagalong.vim";
        rev = "e04ed6f46da5b55450a52e7de1025f1486d55839";
        sha256 = "sha256-h9AFud1mKfNpSSAyltPoCKeZvv/lM3Wx3x8VJVCklS0=";
      };

      meta.homepage = "https://github.com/AndrewRadev/tagalong.vim";
    };
  };
in
{
  programs.neovim.plugins = [ tagalong ];
}
