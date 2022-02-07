{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xfce.thunar
    # Optionals
    xfce.xfconf # Needed to save the preferences
    xfce.exo # Used by default for `open terminal here`, but can be changed
  ];
}
