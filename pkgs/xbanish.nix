{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xbanish
  ];

  # TODO: Figure out how to start xbanish on xsession start
}
