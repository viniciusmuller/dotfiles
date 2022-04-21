{ pkgs, ... }:

{
  services.gpg-agent = {
    # Caches gpg passphrase for 5 hours
    enable = true;
    defaultCacheTtl = 5 * 60 * 60;
    pinentryFlavor = "curses";

    enableSshSupport = true;
    defaultCacheTtlSsh = 5 * 60 * 60;
  };

  home.packages = with pkgs; [
    pinentry
  ];
}
