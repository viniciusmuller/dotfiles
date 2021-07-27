{ pkgs, ... }:

let
  fzf-tab-completion = {
    name = "zsh-tab-completion";
    file = "zsh/fzf-zsh-completion.sh";
    src = pkgs.fetchFromGitHub {
      owner = "lincheney";
      repo = "fzf-tab-completion";
      rev = "53eb325f573265a6105c9bd0aa56cd865c4e14b7";
      sha256 = "sha256-hvlz8/mdg9spKy2RLhqPukqdawd9+MEvW31smCsuUhA=";
    };
  };
  zsh-nix-shell = {
    name = "zsh-nix-shell";
    file = "nix-shell.plugin.zsh";
    src = pkgs.fetchFromGitHub {
      owner = "chisui";
      repo = "zsh-nix-shell";
      rev = "v0.2.0";
      sha256 = "1gfyrgn23zpwv1vj37gf28hf5z0ka0w5qm6286a7qixwv7ijnrx9";
    };
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
        zstyle ':prezto:module:utility' safe-ops 'no'
      '';
    };

    plugins = [
      zsh-nix-shell
      fzf-tab-completion
    ];

    initExtra = ''
      unsetopt BEEP
    '';

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
