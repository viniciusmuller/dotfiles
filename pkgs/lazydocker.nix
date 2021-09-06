{ pkgs, ... }:

{
  home.packages = with pkgs; [ lazydocker ];
  # Workaround since the terminal library used by
  # lazydocker doesn't support tmux
  programs.zsh.shellAliases.lazydocker = "TERM=xterm lazydocker";
  programs.bash.shellAliases.lazydocker = "TERM=xterm lazydocker";
  programs.fish.shellAliases.lazydocker = "TERM=xterm lazydocker";
}

