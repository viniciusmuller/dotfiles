{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    font.package = pkgs.jetbrains-mono;
    font.name = "Jetbrains Mono";
    font.size = 9;

    settings = {
      window_padding_width = 5;
      enable_audio_bell = false;
      disable_ligatures = "always";
    };
  };
}
