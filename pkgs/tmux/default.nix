{ pkgs, config, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = builtins.readFile ./tmux.conf;
    prefix = "C-a";
    plugins = with pkgs; [
      tmuxPlugins.resurrect
    ];
  };

  programs.bash.shellAliases = {
    tl = "tmux ls";
    ta = "tmux attach -t";
    tn = "tmux new -s";
    tk = "tmux kill-session -t";
  };
}
