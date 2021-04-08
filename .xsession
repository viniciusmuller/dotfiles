setxkbmap -layout 'us(intl)'
[[ command -v xmodmap ]] && xmodmap ~/.xmodmap

if command -v wal &> /dev/null
then
  # Restore pywal colorscheme
  wal -R
fi
