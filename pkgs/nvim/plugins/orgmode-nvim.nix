{ pkgs, prelude, ... }:

let
  orgmode = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "orgmode.nvim";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "kristijanhusak";
        repo = "orgmode.nvim";
        rev = "9b412b3a8356d15423f953f90d56c38b8917f290";
        sha256 = "sha256-chAMa6PR88jM356mQAr2T6D11Utzfm60+o1AMZdgT9g=";
      };

      postPatch = "rm Makefile";

      meta.homepage = "https://github.com/kristijanhusak/orgmode.nvim";
    };

    config = "lua require('orgmode').setup{}";
  };
in
{
  programs.neovim.plugins = [ orgmode ];
}
