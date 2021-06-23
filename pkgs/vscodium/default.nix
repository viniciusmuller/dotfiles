{ config, lib, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    userSettings = import ./settings.nix;
    keybindings = import ./keybindings.nix;
    extensions = with pkgs.vscode-extensions; [
      # Aesthetics
      coenraads.bracket-pair-colorizer-2
      zhuangtongfa.material-theme
      pkief.material-icon-theme

      # Utils
      gruntfuggly.todo-tree
      usernamehw.errorlens
      eamodio.gitlens

      # Some vim keybindings
      vscodevim.vim
    ];
  };
}
