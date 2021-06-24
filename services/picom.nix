{ pkgs, ... }:

{
  # TODO: Configure  picom
  services.picom = {
    enable = true;
    activeOpacity = "0.97";
    inactiveOpacity = "0.9";
  };
}
