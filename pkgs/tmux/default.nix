{ pkgs, ... }:

let
  shellConfig = {
    shellAliases = {
      tl = "tmux ls";
      ta = "tmux attach -t";
      tn = "tmux new -s";
      tk = "tmux kill-session -t";
    };
  };
in
{
  # TODO: Tmux seems to be using bash by default #
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
    prefix = "C-a";
    plugins = with pkgs; [
      tmuxPlugins.resurrect
    ];
  };

  programs.bash = shellConfig;
  programs.zsh = shellConfig;

  home.packages = with pkgs; [ xsel ];
}
