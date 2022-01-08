{ pkgs, ... }:

{
  programs.hexchat = {
    enable = true;
    channels =
      {
        libera = {
          autojoin = [
            "#home-manager"
            "#linux"
            "#nixos-chat"
            "#neovim"
          ];
          charset = "UTF-8 (Unicode)";
          commands = [ ];
          loginMethod = "sasl";
          nickname = "arcticlimer";
          options = {
            acceptInvalidSSLCertificates = false;
            # autoconnect = true;
            bypassProxy = true;
            connectToSelectedServerOnly = true;
            useGlobalUserInformation = false;
            forceSSL = true;
          };
          servers = [
            "irc.libera.chat"
          ];
        };
      };
    # settings = {
    #   text_font = "Jetbrains Mono 9";
    # };
    theme = pkgs.fetchzip {
      url = "https://dl.hexchat.net/themes/Monokai.hct#Monokai.zip";
      sha256 = "sha256-WCdgEr8PwKSZvBMs0fN7E2gOjNM0c2DscZGSKSmdID0=";
      stripRoot = false;
    };
  };
}
