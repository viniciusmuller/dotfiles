{ pkgs, ... }:

let
  fzf-tab-completion = pkgs.fetchFromGitHub {
    owner = "lincheney";
    repo = "fzf-tab-completion";
    rev = "53eb325f573265a6105c9bd0aa56cd865c4e14b7";
    sha256 = "sha256-hvlz8/mdg9spKy2RLhqPukqdawd9+MEvW31smCsuUhA=";
  };
in
{
  programs.zsh = {
    enable = true;
    enableSyntaxHighlighting = true;
    autocd = true;

    prezto = {
      enable = true;

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
      ];

      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
      tmux = {
        autoStartRemote = true;
        defaultSessionName = "default";
      };
      syntaxHighlighting = {
        highlighters = [ "main" "brackets" "pattern" "line" "cursor" "root" ];
      };

      extraConfig = ''
        zstyle ':prezto:module:git:alias' skip 'yes'

        . ${fzf-tab-completion}/zsh/fzf-zsh-completion.sh
        bindkey '^I' fzf_completion
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
