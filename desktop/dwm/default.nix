{ pkgs, username, ... }:

# Config for the dynamic window manager
let
  switch = pkgs.writeShellScriptBin "switch" ''
    windows=$(${pkgs.wmctrl}/bin/wmctrl -xl | tr -s '[:blank:]' | cut -d ' ' -f 3-3,5- | sed 's/^[a-zA-Z0-9-]*\.//' | sort | uniq)

    # Add spaces to align the WM_NAMEs of the windows
    max=$(echo "$windows" | awk '{cur=length($1); max=(cur>max?cur:max)} END{print max}')

    windows=$(echo "$windows" | \
                  awk -v max="$max" \
                      '{cur=length($1); printf $1; \
                        for(i=0; i < max - cur + 1; i++) printf " "; \
                        $1 = ""; printf "%s\n", $0}')


    target=$(echo "$windows" | ${pkgs.dmenu}/bin/dmenu $@ -l 10 -i | tr -s '[:blank:]' | cut -d ' ' -f 2-)

    if [[ -n $target ]]; then
        ${pkgs.wmctrl}/bin/wmctrl -a "$target"
    fi
  '';
in
{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.dwm.enable = true;
  };

  programs.slock.enable = true;

  home-manager.users.${username} = {
    imports = [
      ../../services/dunst.nix # Notification daemon
      ../../services/picom.nix # Compositor
      ../../pkgs/kitty.nix # Terminal
      ../../services/gammastep.nix # Screen temperature manager
    ];

    home.packages = with pkgs; [
      flameshot # Screenshots
      wmctrl # Helper for window managers
      xbanish # Hides the mouse when using the keyboard
      switch

      # Overlays from https://github.com/arcticlimer/suckless
      slock
      dmenu
      slstatus
      st
    ];

    home.file = {
      ".config/dwm/autostart.sh".source = ./autostart.sh;
      ".xinitrc".source = ./.xinitrc;
    };
  };
}
