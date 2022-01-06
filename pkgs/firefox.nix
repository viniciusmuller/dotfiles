{ pkgs, username, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.${username} = {
      settings = {
        "ui.key.menuAccessKeyFocuses" = false;
      };
    };
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      bitwarden
      darkreader
      vimium
      privacy-badger
    ];
  };
}
