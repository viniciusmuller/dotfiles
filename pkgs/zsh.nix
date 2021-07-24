{ pkgs, ... }:

let
  # TODO: Try to improve plugin performance #
  # TODO: Install plugins directly in zsh
  fzf-tab = pkgs.fetchFromGitHub {
    owner = "Aloxaf";
    repo = "fzf-tab";
    rev = "bc086fc38cfd680a90c694210fa5c5d88e3d1691";
    sha256 = "sha256-44xYKTF5xduTMrd6NUhRlYuYaSP0OjC2Mg3xjv0KNp4=";
  };
in
{
  home.file = {
    ".config/.zprezto-contrib/fzf-tab".source = fzf-tab;
  };

  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    autocd = true;

    prezto = {
      enable = true;

      pmoduleDirs = [ (builtins.toPath "/home/vini/.config/.zprezto-contrib") ];
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "syntax-highlighting"
        "prompt"
        "tmux"
        "git"
        "fzf-tab"
      ];

      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      # prompt = {
      # TODO: Aparently this is broken #
      #   showReturnVal = true;
      # };
      tmux = {
        autoStartRemote = true;
        defaultSessionName = "default";
      };
      syntaxHighlighting = {
        highlighters = [ "main" "brackets" "pattern" "line" "cursor" "root" ];
      };

      extraConfig = ''
        zstyle ':prezto:module:git:alias' skip 'yes'
      '';
    };

    # TODO: Make these kind of things common between different shells #
    shellAliases = {
      c = "clear";
      b = "cd -";
      se = "sudoedit";
      ns = "nix-shell -p";
    };

    sessionVariables = {
      EDITOR = "vim";
      FZF_DEFAULT_OPTS = ''--prompt \" λ \"'';
    };
  };
}
