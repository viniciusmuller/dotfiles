{ pkgs, ... }:

let
  mpv = "${pkgs.mpv}/bin/mpv";
  glow = "${pkgs.glow}/bin/glow";
  pandoc = "${pkgs.pandoc}/bin/pandoc";
in
{
  imports = [ ./mpv.nix ];

  programs.newsboat = {
    enable = true;
    autoReload = true;
    urls = [
      # {
      #   title = "Lobste.rs - Nix/Go";
      #   url = "https://lobste.rs/t/nix,go.rss";
      #   tags = [ "tech" "go" "nix" ];
      # }
      # Aggregators
      {
        title = "Lobste.rs - Frontpage";
        url = "https://lobste.rs/rss";
        tags = [ "tech" ];
      }
      {
        title = "Hacker News - Frontpage";
        url = "https://news.ycombinator.com/rss";
        tags = [ "tech" ];
      }

      # Blogs
      {
        title = "Drew DeVault's";
        url = "https://drewdevault.com/blog/index.xml";
        tags = [ "tech" ];
      }
      {
        title = "The Go Programming Language Blog";
        url = "https://go.dev/blog/feed.atom?format=xml";
        tags = [ "tech" "go" ];
      }
      {
        title = "The Elixir Programming Language Blog";
        url = "https://elixir-lang.org/atom.xml";
        tags = [ "tech" "elixir" ];
      }
      {
        title = "Dashbit Blog";
        url = "https://dashbit.co/feed";
        tags = [ "tech" "elixir" ];
      }
      {
        title = "uses this";
        url = "https://usesthis.com/feed.atom";
        tags = [ "tech" "entertainment" ];
      }
      {
        title = "Julia Evans";
        url = "https://jvns.ca/atom.xml";
        tags = [ "tech" ];
      }
      {
        title = "Existential Type";
        url = "https://existentialtype.wordpress.com/feed/";
        tags = [ "tech" ];
      }
      {
        title = "research!rsc";
        url = "https://research.swtch.com/feed.atom";
        tags = [ "tech" ];
      }
      {
        title = "The Pragmatic Engineer";
        url = "http://feeds.feedburner.com/ThePragmaticEngineer";
        tags = [ "tech" ];
      }
      {
        title = "Glorified Gluer";
        url = "https://gluer.org/blog/atom.xml";
        tags = [ "tech" ];
      }

      # Reddit
      # {
      #   url = "https://www.reddit.com/r/neovim/.rss";
      #   title = "/r/neovim";
      #   tags = [ "neovim" "reddit" ];
      # }
      # {
      #   url = "https://www.reddit.com/r/linux/.rss";
      #   title = "/r/linux";
      #   tags = [ "linux" "reddit" ];
      # }
      # {
      #   url = "https://www.reddit.com/r/NixOS/.rss";
      #   title = "/r/NixOS";
      #   tags = [ "linux" "nixos" "reddit" ];
      # }
      # {
      #   url = "https://www.reddit.com/r/elixir/.rss";
      #   title = "/r/elixir";
      #   tags = [ "programming" "elixir" "reddit" ];
      # }
      # {
      #   url = "https://www.reddit.com/r/rust/.rss";
      #   title = "/r/rust";
      #   tags = [ "programming" "rust" "reddit" ];
      # }
      # {
      #   url = "https://www.reddit.com/r/golang/.rss";
      #   title = "/r/golang";
      #   tags = [ "programming" "go" "reddit" ];
      # }

      # Youtube
      {
        title = "Computerphile";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9-y-6csu5WGm29I7JiwpnA";
        tags = [ "tech" "youtube" ];
      }
      {
        title = "carykh";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC9z7EZAbkphEMg0SP7rw44A";
        tags = [ "tech" "youtube" ];
      }
      {
        title = "CodeParade";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCrv269YwJzuZL3dH5PCgxUw";
        tags = [ "tech" "youtube" ];
      }
      {
        title = "Code Bullet";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC0e3QhIYukixgh5VVpKHH9Q";
        tags = [ "tech" "youtube" ];
      }
      {
        title = "Tsoding Daily";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCrqM0Ym_NbK1fqeQG2VIohg";
        tags = [ "tech" "youtube" ];
      }
      {
        title = "Sebastian Lague";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCmtyQOKKmrMVaKuRXz02jbQ";
        tags = [ "tech" "youtube" ];
      }
      {
        title = "Fabio Akita";
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCib793mnUOhWymCh2VJKplQ";
        tags = [ "tech" "youtube" ];
      }
    ];
    extraConfig = ''
      # misc
      refresh-on-startup yes

      # display
      feed-sort-order unreadarticlecount-asc
      text-width      72

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
      bind-key g home
      bind-key G end

      # colorscheme
      color listnormal        white black
      color listnormal_unread white black
      color listfocus         white black bold reverse
      color listfocus_unread  white black bold reverse
      color info              white black reverse bold
      color background        white black
      color article           white black

      html-renderer "${pandoc} --from=html -t markdown_github-raw_html"
      pager "${glow} --pager --width 72"

      # macros
      macro v set browser "${mpv} %u" ; open-in-browser ; set browser "firefox %u" -- "Open video on mpv"
    '';
  };
}
