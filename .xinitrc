#!/bin/sh

check_command() {
  command -v $1 &>/dev/null
}

# Source xmodmap layout if it's installed
check_command "xmodmap" && xmodmap ~/.xmodmap
# Start compositor
check_command "picom" && picom &
# Blue light filter
check_command "blugon" && blugon &
# Notifications daemon
check_command "dunst" && dunst &
# Remove cursor from screen when it's not being used
check_command "xbanish" && xbanish &
# Restore background
check_command "restore_bg" && restore_bg &

# X screen locking daemon
notifier="notify-send -u critical -t 14000 -- 'LOCKING screen in 15 seconds'"
xautolock_parameters="-corners 000- -time 15 -locker slock -notify 15 -notifier $notifier"
check_command "xautolock" && xautolock $autolock_parameters &

exec dwm
