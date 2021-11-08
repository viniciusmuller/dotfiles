{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "toggle_layout" ''
      layout=$(setxkbmap -print | awk -F"+" '/xkb_symbols/ {print $2}')

      case $layout in
        'us(intl)')
          setxkbmap -layout us
        ;;
        'us')
          setxkbmap -layout 'us(intl)'
        ;;
      esac
    '')
  ];
}
