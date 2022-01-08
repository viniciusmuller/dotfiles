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
  };
}
