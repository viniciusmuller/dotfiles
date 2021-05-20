{ config, pkgs, ... }:

let base16 = pkgs.fetchFromGitHub {
    owner = "chriskempson";
    repo = "base16-shell";
    rev = "ce8e1e540367ea83cc3e01eec7b2a11783b3f9e1";
    sha256 = "1yj36k64zz65lxh28bb5rb5skwlinixxz6qwkwaf845ajvm45j1q";
};
in {
  home.packages = with pkgs; let
    cli = [
      lazydocker # Docker TUI
      bandwhich  # Network inspector
      neofetch   # Display system info
      tealdeer   # TLDR of man pages
      rmtrash    # Safer /bin/rm

      # Finders
      fzf       # Fuzzy finder
      ripgrep   # File content finder
      fd        # File finder

      # Git related
      delta     # Diff viewer
      git

      # Utils
      zoxide    # Directory jumper
      xsv       # Work with csv
      jq        # Work with json
      bat       # File viewer

      lolcat
      stow      # Symlinks manager
      ncdu      # Curses interface for `du`
      tmux      # Terminal multiplexer
      vifm      # File manager
    ];
    gui = [
      # TODO: Find out why apparently there are OpenGL related
      # drivers errors on home-manager installed GUI programs
      nerdfonts # Patched fonts
      firefox   # Browser
      kitty     # Terminal
      picom     # Compostior
      dunst     # Desktop notifications daemon
      sxiv      # Simple X image viewer
      flameshot # Screenshots
      mupdf     # Pdf viewer
      feh       # Background setter
    ];
  in gui ++ cli;

  /* TODO: Use XDG variables */
  home.file = {
    ".config/base16-shell".source = base16;
    /* TODO: Make vim use ~/.vim directory */
  };

  programs = {
    vim = with pkgs.vimPlugins; {
      enable = true;
      plugins = [
        vim-plug
      ];
      /* TODO Make vim-plug work */
      extraConfig = builtins.readFile ../../.vim/vimrc;
    };
    firefox = {

    };
    zsh = let
      mkZshPlugin = { pkg, file ? "${pkg.pname}.plugin.zsh" }: rec {
        name = pkg.pname;
        src = pkg.src;
        inherit file;
      };
    in {
      enable = true;
      initExtra = builtins.readFile ../../.zshrc;

      plugins = with pkgs; [
        (mkZshPlugin { pkg = zsh-autopair; })
        (mkZshPlugin { pkg = zsh-completions; })
        (mkZshPlugin {
          pkg = zsh-fzf-tab;
          file = "fzf-tab.plugin.zsh";
        })
        (mkZshPlugin { pkg = zsh-autosuggestions; })
        (mkZshPlugin {
          pkg = zsh-fast-syntax-highlighting;
          file = "fast-syntax-highlighting.plugin.zsh";
        })
        (mkZshPlugin { pkg = zsh-history-substring-search; })
      ];
      oh-my-zsh = {
        enable = true;
        theme = "af-magic";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "vini";
  home.homeDirectory = "/home/vini";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
