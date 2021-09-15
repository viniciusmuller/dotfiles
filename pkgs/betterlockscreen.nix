{pkgs, ...}:

{
  # TODO: Upstream home-manager currently has this, maybe one day use it from it
  home.packages = with pkgs; [
    betterlockscreen
    feh
  ];
}
