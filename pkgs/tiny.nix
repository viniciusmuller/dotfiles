{ ... }:

{
  programs.tiny = {
    enable = true;
    settings = {
      servers = [
        {
          addr = "irc.libera.chat";
          port = 6697;
          tls = true;
          realname = "Vinícius";
          nicks = [ "arcticlimer" ];
          join = [ "#linux" "#neovim" ];
        }
      ];
      defaults = {
        nicks = [ "arcticlimer" ];
        realname = "Vinícius";
        join = [ ];
        tls = true;
      };
    };
  };
}
