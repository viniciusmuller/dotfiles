{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    # package = pkgs.neovim-nightly;
  };
}