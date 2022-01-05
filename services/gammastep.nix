{ ... }:

{
  services.gammastep = {
    enable = true;
    dawnTime = "6:00-7:45";
    duskTime = "18:35-20:15";
    temperature = {
      # Lower = Hotter
      day = 3500;
      night = 2500;
    };
    settings = {
      general = {
        brightness-day = 1.0;
        brightness-night = 0.6;
      };
    };
  };
}
