{ pkgs, ... }:

let
  extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "magit";
      publisher = "kahole";
      version = "0.6.18";
      sha256 = "sha256-/Dhd3gfGKT9fVWDrJB2vT5ycu8Ws8329AuZhvFb5H2s=";
    }
  ];

in
{
  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      vspacecode.vspacecode
      vspacecode.whichkey
      vscodevim.vim
    ] ++ extensions;
    keybindings = builtins.fromJSON (builtins.readFile ./vspacecode-keybindings.json);
    userSettings = builtins.fromJSON (builtins.readFile ./vspacecode-settings.json);
  };
}
