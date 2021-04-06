<h1 align="center">My linux setup and dotfiles</h1>

## Installation
- Nice mode: Take a look at the setup and dotfiles and symlink the files that you'd like to try
- Hardcore mode: `ln -s config ~/.config`

> Not all the dotfiles here keeps at `~/.config`, check the setup below for info on where you should link the dotfiles.

## Structure
- `config`: Dotfiles directory
- `bin`: Some useful scripts that I wrote and are used in the dotfiles

## Setup
- OS: `Arch Linux`

- Bootloader: `grub`

  - Theme: [`fallout`](https://github.com/shvchk/fallout-grub-theme)

- CLI:

  - Terminal: [`kitty`](https://wiki.archlinux.org/index.php/Kitty#Installation)
    - Font: [`Jetbrains Mono`](https://archlinux.org/packages/community/any/ttf-jetbrains-mono)
    - Dotfiles path: `~/.config/kitty/`

  - Shell: [`zsh`](https://wiki.archlinux.org/index.php/zsh#Installation)
    - Framework: [`oh-my-zsh!`](https://github.com/ohmyzsh/ohmyzsh#basic-installation)
      - Theme: [`spaceship`](https://github.com/denysdovhan/spaceship-prompt)
    - Plugins:
      - [`zsh-vi-mode`](https://github.com/jeffreytse/zsh-vi-mode#arch-linux-aur)
      - [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh)
    - Dotfile path: `~/.zshrc`

  - Terminal multiplexer: [`tmux`](https://wiki.archlinux.org/index.php/Tmux#Installation)
    - Dotfile path: `~/.tmux.conf`

  - Unix commands replacements:

    - ls: [`exa`](https://github.com/ogham/exa#arch-linux)
    - cat: [`bat`](https://github.com/sharkdp/bat#on-arch-linux)
    - grep: [`rg`](https://github.com/BurntSushi/ripgrep#installation)
    - top: [`ytop`](https://github.com/cjbassi/ytop#installation)
    - find: [`fd`](https://github.com/sharkdp/fd#on-arch-linux)
    - du [`dust`](https://github.com/bootandy/dust)

  - Useful programs:
    - [`tealdeer`](https://github.com/dbrgn/tealdeer)
    - [`tig`](https://github.com/jonas/tig)
    - [`lazydocker`](https://github.com/jesseduffield/lazydocker)
    - [`grit`](https://github.com/climech/grit)
    - [`bandwhich`](https://github.com/imsnif/bandwhich)


- Display server: [`xorg`](https://wiki.archlinux.org/index.php/xorg#Installation)
  - Modify keyboard mappings: [`xmodmap`](https://wiki.archlinux.org/index.php/xmodmap#Installation)
    ```bash
    # In order to support cedilla on ´+c, use this:
    sudo sed -i /usr/share/X11/locale/en_US.UTF-8/Compose -e 's/ć/ç/g' -e 's/Ć/Ç/g'
    ```

- Display manager: [`lightdm`](https://wiki.archlinux.org/index.php/LightDM#Installation)

  - Greeter: `lightdm-webkit2-greeter`

    - Theme: [`Aether`](https://github.com/NoiSek/Aether#installation)

- Window managers:

  - [`awesome`](https://wiki.archlinux.org/index.php/awesome#Installation):

    - Theme: https://github.com/arcticlimer/UwU
    - Dotfiles path: `~/.config/awesome/`

  - [`i3`](https://wiki.archlinux.org/index.php/i3):
    - Custom scripts:
      - Lock Screen (Mod+m): `bin/myi3lock`
      - Toggle layout (Mod+p): `bin/toggle_layout`

    - Dotfiles path: `~/.config/i3/`

    - Status bar: [`i3status-rust`](https://github.com/greshake/i3status-rust):

      - Dotfiles path: `~/.config/i3status-rust/`

- Screenlocking:

  - Locker: [`i3lock-colors`](https://aur.archlinux.org/packages/i3lock-color/)
    - Custom script: [`myi3lock`](bin/myi3lock)
  - Helper: [`xautolock`](https://archlinux.org/packages/community/x86_64/xautolock)

- Software mixer: [`pulseaudio`](https://wiki.archlinux.org/index.php/PulseAudio#Installation)

  - Mixer: `pulsemixer`
  - Dotfile path: `~/.config/pulse/client.conf`

* Browser: [`firefox`](https://wiki.archlinux.org/index.php/Firefox#Installing):
  - Theme: [`pywalfox`](https://github.com/frewacom/pywalfox)

- Notifications daemon: [`dunst`](https://wiki.archlinux.org/index.php/Dunst#Installation)

- Compositor: [`picom`](https://wiki.archlinux.org/index.php/Picom#Installation)

  - Dotfile path: `~/.config/picom/picom.conf`

- Development:

  - Editors:

    - [`vim`](https://wiki.archlinux.org/index.php/vim#Installation):

      - Dotfiles path: `~/.vim`
      - Plugin manager: [`vim-plug`](https://github.com/junegunn/vim-plug#installation)

    - [`Emacs 28+ natively compiled`](https://aur.archlinux.org/packages/emacs-native-comp-git)
      - Font: [`Jetbrains Mono`](https://archlinux.org/packages/community/any/ttf-jetbrains-mono)
      - Framework: [`Doom Emacs`](https://github.com/hlissner/doom-emacs#install)
        - Dotfiles path: `~/.config/doom`

    - [`vscode`](https://aur.archlinux.org/packages/visual-studio-code-bin/):

      - Theme: `BeardedTheme Anthracite`
      - Settings path: `~/.config/Code/User/settings.json`

* Languages version manager: [`asdf`](https://asdf-vm.com/#/core-manage-asdf?id=asdf)

* Databases:

  - [`PostgreSQL`](https://wiki.archlinux.org/index.php/PostgreSQL)
  - [`MariaDB`](https://wiki.archlinux.org/index.php/MariaDB)

* Database client: [`beekeeper-studio`](https://aur.archlinux.org/packages/beekeeper-studio-bin/)
* REST client: [`insomnia`](https://aur.archlinux.org/packages/insomnia/)
* Containers: [`docker[-compose]`](https://wiki.archlinux.org/index.php/Docker)

- File manager: [`ranger`](https://wiki.archlinux.org/index.php/ranger):
  - Images previewer: [`ueberzug`](https://archlinux.org/packages/community/x86_64/ueberzug/)
  - Dotfiles path: `~/.config/ranger/`

* Editing:

  - Image manipulation: [`gimp`](https://wiki.archlinux.org/index.php/GIMP#Installation)
    - Theme: [`GimpPs`](https://github.com/doctormo/GimpPs#basic-installation)
  - Pixel art: [`aseprite`](https://aur.archlinux.org/packages/aseprite/)
    - Theme: [`aseprite-studio-theme`](https://github.com/Lyutria/aseprite-studio-theme#usage)

* Ricing:

  - [`pywal`](https://github.com/dylanaraps/pywal)
  - [`cava`](https://aur.archlinux.org/packages/cava)
  - [`tty-clock`](https://aur.archlinux.org/packages/tty-clock)

* Others:

  - Screenshots: [`flameshot`](https://wiki.archlinux.org/index.php/Flameshot)
  - Wallpaper manager: [`nitrogen`](https://wiki.archlinux.org/index.php/nitrogen)
  - PDF reader: [`zathura`](https://wiki.archlinux.org/index.php/zathura#Installation)
  - Note taking: [`obsidian`](https://aur.archlinux.org/packages/obsidian-insider/)
  - Blue light filter: [`blugon`](https://aur.archlinux.org/packages/blugon)
  - File finder: [`fzf`](https://wiki.archlinux.org/index.php/fzf#Installation)
  - Color picker: [`xcolor`](https://github.com/Soft/xcolor#arch-linux)
  - Launcher: [`Luke Smith's dmenu fork`](https://github.com/LukeSmithxyz/dmenu)

<h2>👀 Preview:</h2>
<img src="https://i.imgur.com/9xersCi.png" alt="desktop preview">
<img src="https://i.imgur.com/BYu2y6O.png" alt="desktop preview">
