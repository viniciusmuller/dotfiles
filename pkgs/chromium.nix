{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # Ublock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark reader
      "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    ];
  };
}
