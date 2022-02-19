{ pkgs, ... }:

let
  termbin = pkgs.writeShellScriptBin "tb" ''
    if [ -z $1 ]
    then
      cat $1 | ${pkgs.netcat}/bin/nc termbin.com 9999
    fi
  '';
in
{
  home.packages = [
    termbin
  ];
}
