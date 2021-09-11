{ pkgs, ... }:

{
  programs.newsboat = {
    enable = true;
    autoReload = true;
    urls = [
      {
        url = "https://hnrss.org/newest";
        title = "Hacker News";
        tags = [ "linux" "technology" ];
      }
      {
        url = "https://www.reddit.com/r/neovim/.rss";
        title = "/r/neovim";
        tags = [ "neovim" ];
      }
      {
        url = "https://www.reddit.com/r/linux/.rss";
        title = "/r/linux";
        tags = [ "linux" ];
      }
      {
        url = "https://www.reddit.com/r/NixOS/.rss";
        title = "/r/NixOS";
        tags = [ "linux" "nixos" ];
      }
      {
        url = "https://www.reddit.com/r/elixir/.rss";
        title = "/r/elixir";
        tags = [ "programming" "elixir" ];
      }
      {
        url = "https://www.reddit.com/r/rust/.rss";
        title = "/r/rust";
        tags = [ "programming" "rust" ];
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
      color listnormal        white black
      color listnormal_unread white black
      color listfocus         white black bold reverse
      color listfocus_unread  white black bold reverse
      color info              white black reverse bold
      color background        white black
      color article           white black
    '';
  };
}
