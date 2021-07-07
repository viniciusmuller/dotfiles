{ pkgs, ... }:

{
  home.packages = with pkgs; [
    asciiquarium # it's an ascii aquarium :O
    tty-clock # it's a tty-clock
    neofetch # Display system info
    cmatrix # oh yes a matrix
    cowsay # A cow that say whatever you want
    lolcat # Rainbow text
    pfetch # Cute neofetch
    cava # TUI Audio visualizer
  ];
}
