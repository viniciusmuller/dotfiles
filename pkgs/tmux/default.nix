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
}

