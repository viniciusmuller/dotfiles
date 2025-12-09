{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [
      "pkehgijcmpdhfbdbbnkijodmdjhbjlgp" # Privacy badger
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # Ublock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark reader
    ];
  };
}
