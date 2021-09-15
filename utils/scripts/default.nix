{ pkgs, ... }:

{
  # TODO: sessionPath is not working :(
  # home.sessionPath = [ "${./bin}" ];
  programs.bash.initExtra = ''export PATH=${./bin}:$PATH'';
  programs.zsh.initExtra = ''export PATH=${./bin}:$PATH'';
  # programs.fish.initExtra = ''export PATH=${./bin}:$PATH'';
  home.packages = [ pkgs.jq ];
}
