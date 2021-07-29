{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    activeOpacity = "0.97";
    inactiveOpacity = "0.92";
    opacityRule = [
      "100:name *= 'i3lock'"
      "99:fullscreen"
    ];
    extraOptions = ''
      xrender-sync-fence = true;
      use-ewmh-active-win = true;
      inactive-opacity-override = true;
    '';
  };
}
