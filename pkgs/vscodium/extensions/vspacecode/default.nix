{ pkgs, ... }:

{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      kahole.magit
      vspacecode.vspacecode
      vspacecode.whichkey
      vscodevim.vim
    ];
    keybindings = builtins.fromJSON (builtins.readFile ./vspacecode-keybindings.json);
    userSettings = builtins.fromJSON (builtins.readFile ./vspacecode-settings.json);
  };
}
