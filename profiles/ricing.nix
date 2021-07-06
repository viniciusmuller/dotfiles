{ pkgs, ... }:

{
  home.packages = with pkgs; [
    asciiquarium # it's an ascii aquarium :O
    tty-clock # it's a tty-clock
    neofetch # Display system info
    cmatrix # oh yes a matrix
    lolcat # Rainbow text
    pfetch # Cute neofetch
    cava # TUI Audio visualizer
  ];
}
