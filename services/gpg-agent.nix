{ pkgs, ... }:

{
  services.gpg-agent = {
    # Caches gpg passphrase
    enable = true;
  };

  home.packages = with pkgs; [
    pinentry
  ];
}
