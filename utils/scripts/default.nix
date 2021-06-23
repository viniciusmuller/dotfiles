{ ... }:

{
  programs.bash.initExtra = ''
    export PATH=$PATH:${./bin}
  '';
}
