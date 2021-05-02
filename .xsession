check_command() {
  command -v $1 &>/dev/null
}

# Source xmodmap layout if it's installed
check_command "xmodmap" && xmodmap ~/.xmodmap
 # Restore nitrogen wallpaper
check_command "nitrogen" && nitrogen --restore
# Start compositor
check_command "picom" && picom &
# Blue light filter
check_command "blugon" && blugon &

# If we are running dwm, launch slstatus
[[ $XDG_SESSION_DESKTOP == "dwm" ]] && (slstatus &) && ls
notifier="notify-send -u critical -t 14000 -- 'LOCKING screen in 15 seconds'"
xautolock_parameters="-corners 000- -time 15 -locker slock -notify 15 -notifier $notifier"
check_command "xautolock" && xautolock $autolock_parameters &
