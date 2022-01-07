{ pkgs, ... }:

let
  sprunge = pkgs.writeShellScriptBin "sprunge" ''
    if [ -z $1 ]
    then
        curl -s -F 'sprunge=<-' http://sprunge.us
    else
        if [ -z $2 ]
        then
            echo -n "$1:"
            cat $1 | $0
        else
            for i in $@
            do
                $0 $i
            done
        fi
    fi
  '';
in
{
  home.packages = [
    sprunge
    pkgs.curl
  ];
}
