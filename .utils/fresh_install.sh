install_suckless() {
  git clone https://github.com/arcticlimer/suckless ~/suckless
  (cd ~/suckless && sudo sh install_all.sh)
}

install_yay() {
  git clone https://aur.archlinux.org/yay.git
  (cd yay && makepkg -si)
}

core="base-devel alsa-utils pulseaudio"
cli="stow man tmux vim exa bat fzf fd ripgrep ncdu trash-cli bandwhich vifm lolcat"
gui="xorg-server xorg-xinit dunst picom feh sxiv mupdf xautolock firefox kitty
ttf-jetbrains-mono ttf-dejavu"

aur="zoxide ytop lazydocker git-delta-bin blugon nerd-fonts-jetbrains-mono
xbanish"

sudo pacman -S --needed $core $cli $gui

[ ! command -v yay &>/dev/null ] && install_yay
yay -S --needed $aur

[ ! -d ~/suckless ] && install_suckless
