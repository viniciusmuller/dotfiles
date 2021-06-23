{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # Ublock origin
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark reader
      "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
      "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
      {
        id = "cjnmckjndlpiamhfimnnjmnckgghkjbl"; # Competitive companion
        version = "2.25.2";
      }
      {
        id = "miljekjnhkpkelpomeehcbhlanppjegn"; # Material dark theme
        version = "1.0";
      }
    ];
  };
}
