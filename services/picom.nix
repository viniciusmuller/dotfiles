{ pkgs, ... }:

{
  # TODO: Configure  picom
  services.picom = {
    enable = true;
    activeOpacity = "0.9";
    inactiveOpacity = "0.8";
  };
}
