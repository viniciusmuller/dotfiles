{ pkgs, ... }:

let
  coq = {
    plugin = pkgs.vimUtils.buildVimPlugin {
      name = "coq_nvim";
      version = "2021-07-07";

      src = pkgs.fetchFromGitHub {
        owner = "ms-jpq";
        repo = "coq_nvim";
        rev = "93bd544d9f9acd1a9e31cee6a36c6ed20c3fc7de";
        sha256 = "sha256-gB97HNvZgkGa0qV3vRH6XJ9FxZnBoMHF84Q39CE3a0c=";
      };

      meta.homepage = "https://github.com/ms-jpq/coq_nvim";
    };

    config = "";
  };
in
{
  programs.neovim.plugins = [ coq ];
}
