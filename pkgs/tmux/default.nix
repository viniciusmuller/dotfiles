{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
    prefix = "C-a";
    plugins = with pkgs; [
      tmuxPlugins.resurrect
    ];
  };

  programs.bash = {
    initExtra = ". ${./tmux-session-fzf}";

    shellAliases = {
      tl = "tmux ls";
      ta = "tmux attach -t";
      tn = "tmux new -s";
      tk = "tmux kill-session -t";
    };
  };

  home.packages = with pkgs; [ xsel ];
}
