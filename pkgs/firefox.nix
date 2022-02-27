{ pkgs, username, ... }:

{
  # home.packages = [ pkgs.firefox-wayland ];

  # Home Manager setup
  # home.sessionVariables = {
  #   MOZ_ENABLE_WAYLAND = 1;
  #   XDG_CURRENT_DESKTOP = "sway";
  # };

  programs.firefox = {
    enable = true;
    # package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
    #   forceWayland = true;
    #   extraPolicies = {
    #     ExtensionSettings = { };
    #   };
    # };
    # profiles.${username} = {
    #   settings = {
    #     "ui.key.menuAccessKeyFocuses" = false;
    #   };
    # };
    # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #   multi-account-containers
    #   ublock-origin
    #   bitwarden
    #   darkreader
    #   vimium
    #   privacy-badger
    # ];
  };
}
