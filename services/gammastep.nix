{ ... }:

{
  services.gammastep = {
    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    temperature = {
      # Lower = Hotter
      day = 3000;
      night = 2000;
    };
    settings = {
      general = {
        brightness-day = 1.0;
        brightness-night = 0.7;
      };
      # randr = {
      #   screen = 0;
      # };
    };
  };
}
