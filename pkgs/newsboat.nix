{ pkgs, ... }:

{
  programs.newsboat = {
    enable = true;
    urls = [
      {
        url = "https://hnrss.org/newest";
        tags = [ "linux" "technology" ];
      }
      {
        url = "https://www.reddit.com/r/neovim/.rss";
        tags = [ "neovim" ];
      }
      {
        url = "https://www.reddit.com/r/linux/.rss";
        tags = [ "linux" ];
      }
    ];
    extraConfig = ''
      # unbind keys
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K

      # bind keys - vim style
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit

      # colorscheme
      color listnormal        red black
      color listnormal_unread red black
      color listfocus         red black bold reverse
      color listfocus_unread  red black bold reverse
      color info              red black reverse bold
      color background        red black
      color article           red black
    '';
  };
}
