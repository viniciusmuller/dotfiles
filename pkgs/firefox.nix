{ config, lib, pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        profiles.arcticlimer {
          "ui.key.menuAccessKeyFocuses" = false;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          dark-reader
          bitwarden
          vimium-ff
        ];
    };
}
