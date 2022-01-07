{ pkgs, ... }:

{
  programs.hexchat = {
    # TODO: Improve this config
    enable = true;
    channels =
      {
        libera = {
          autojoin = [
            "#home-manager"
            "#linux"
            "#nixos"
          ];
          charset = "UTF-8 (Unicode)";
          commands = [
            # "ECHO Buzz Lightyear sent you a message: 'To Infinity... and Beyond!'"
          ];
          loginMethod = "sasl";
          nickname = "my_nickname";
          options = {
            acceptInvalidSSLCertificates = false;
            autoconnect = true;
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
