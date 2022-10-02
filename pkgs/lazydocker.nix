{ pkgs, ... }:

{
  home.packages = with pkgs; [ lazydocker ];
  # Workaround since the terminal library used by
  # lazydocker doesn't support tmux
  programs.bash.shellAliases.lazydocker = "TERM=xterm lazydocker";
}

