{ pkgs, ... }:

{
  services.gpg-agent = {
    # Caches gpg passphrase
    enable = true;
    defaultCacheTtl = 5 * 60 * 60;
  };

  home.packages = with pkgs; [
    pinentry
  ];
}
