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
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
    prefix = "C-a";
    plugins = with pkgs; [
      # tmuxPlugins.tmux-fzf # TODO: Wait until these 2 get fixed upstream
      # tmuxPlugins.vim-tmux-navigator

      tmuxPlugins.yank
      tmuxPlugins.sensible
      tmuxPlugins.resurrect
    ];
  };

  programs.bash = shellConfig;
  programs.zsh = shellConfig;
}
