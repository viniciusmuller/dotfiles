{ pkgs, ... }:

let
  remnote = pkgs.appimageTools.wrapType2 {
    name = "remnote";
    src = pkgs.fetchurl {
      url = "https://download.remnote.io/RemNote-1.3.15.AppImage";
      sha256 = "sha256-Vt+pN0jSDamFL6YPFyG0ufe+4lmhzmAw5YuEq1HmeVo=";
    };
  };
in
{
  home.packages = [ remnote ];
}
