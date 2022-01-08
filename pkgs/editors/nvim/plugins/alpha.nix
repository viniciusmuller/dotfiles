{ pkgs, prelude, ... }:

let
  alpha = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "alpha-nvim";
      version = "2022-01-08";
      src = pkgs.fetchFromGitHub {
        owner = "goolord";
        repo = "alpha-nvim";
        rev = "e43067e7990ab800f623afb3f5743adcc8274ec2";
        sha256 = "sha256-44mSqzis4hxlg1F4dIQ5m6N8fLX3L0iNqJ1OiKFts4Q=";
      };
      # TODO: Vim can't build tags 
      prePatch = "rm -r doc";
      meta.homepage = "https://github.com/goolord/alpha-nvim";
    };

    config = prelude.mkLuaCode ''
      require('alpha').setup(require('alpha.themes.startify').opts)
    '';
  };
in
{
  programs.neovim.plugins = [ alpha ];
}
