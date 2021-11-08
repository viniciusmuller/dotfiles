{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "backup-home" ''
      # Run this from your home directory
      # TODO: --exclude doesn't appear to be working
      tar cf - --exclude='.cache' --exclude='.local/share/Steam' --exclude='.local/share/Trash'--exclude='.cargo' . | pv -s $(du -sb . | awk '{print $1}') | gzip > backup-$(date +%d-%m-%Y).tar.gz
    '')
    pkgs.pv
  ];
}
