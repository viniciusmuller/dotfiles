{ pkgs, ... }:

let
  vi_mode = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/shabble/irssi-scripts/master/vim-mode/vim_mode.pl";
    sha256 = "1vabyvxwiqnprijzn9wrz0dn65ai48kmzmri2kwk2qca178x2ry6";
  };

  uberprompt = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/shabble/irssi-scripts/master/prompt_info/uberprompt.pl";
    sha256 = "1ypccskp8y6l2xrpdmis85xmfs2q6vqklnmxw4q5hgyy5m8g7626";
  };

  theme = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/irssi-import/themes/gh-pages/h3rbz.theme";
    sha256 = "0fh08xcj575s344bp4gqy2vq2rj775ypyyipbl60jgnpy277ww6s";
  };
in
{
  programs.irssi = {
    enable = true;

    networks = {
      libera = {
        nick = "arcticlimer";
        server = {
          address = "irc.libera.chat";
          port = 6697;
          autoConnect = true;
        };
      };
    };
  };

  home.file = {
    ".irssi/scripts/autorun/vim_mode.pl".source = vi_mode;
    ".irssi/scripts/autorun/uberprompt.pl".source = uberprompt;
    ".irssi/default.theme".source = theme;
  };
}
