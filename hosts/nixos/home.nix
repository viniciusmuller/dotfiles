{ config, pkgs, inputs, lib, username, colorscheme, ... }:

let
  rebuild-alias = {
    rb = "sudo nixos-rebuild switch --flake '.#nixos'";
  };
  fonts = with pkgs; [
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
  ];
  cli = with pkgs; [
    bandwhich # Network inspector
    ripgrep # File content finder
    htop # System monitor
    ncdu # Curses interface for `du`
    file # Show info about files
    fd # File finder
    unzip # Easily unzip files
    neofetch
    pfetch # lightweight neofetch
    git-imerge
    kubectl
    minikube
  ];
  gui = with pkgs; [
    retroarch
    jetbrains.rider # code editor
    lapce # code editor
    okular # ebook reader
    thunderbird # email client
    insomnia # Request testing
    beekeeper-studio # database client
    gnome-solanum # pomodoro timer
    gnome.gnome-calendar # calendar
    anki-bin # Spaced repetition
    # krita # Digital art
    firefox # browser
    calibre # Ebook manager
    element-desktop # Matrix client
    logseq # Note taking app
    godot_4 # Game engine
    libresprite # pixel art editor
    antimicroX # convert joystick input to keyboard input
    sioyek # technical paper reader
  ];
  games = with pkgs; [
    # nethack
    # cataclysm-dda
  ];
  proprietary = with pkgs; [
    discord
    # zoom-us
    # spotify
  ];
in
{
  imports = [
    ../../utils/scripts
    ../../profiles/haskell # ghci customization

    # CLI
    ../../pkgs/base16-shell.nix # Different shell themes
    ../../pkgs/bash.nix # Shell
    ../../pkgs/nix-index.nix # Show nixpkgs' packages of uninstalled binaries
    ../../pkgs/zoxide.nix # Jump directories
    ../../pkgs/editors/nvim # Modal text editor
    ../../pkgs/readline # GNU readline input
    ../../pkgs/git.nix
    ../../pkgs/tmux # Terminal multiplexer
    ../../pkgs/fzf.nix # Fuzzy finder
    ../../pkgs/bat.nix # File previewer
    ../../pkgs/exa.nix # ls alternative
    ../../pkgs/newsboat.nix # RSS Reader
    ../../pkgs/trash-cli.nix # Safer rm
    ../../pkgs/direnv.nix # Manages project environments
    ../../pkgs/keychain.nix
    ../../pkgs/gpg.nix
    ../../pkgs/jq.nix # Work with json
    ../../pkgs/nnn.nix # File manager
    ../../pkgs/tiny.nix # IRC Client
    ../../services/gpg-agent.nix
    ../../services/gammastep.nix # Screen temperature manager
    ../../services/dunst.nix # notification daeomn

    # GUI
    # ../../pkgs/wayst.nix # terminal emulator
    ../../pkgs/kitty.nix
    ../../pkgs/editors/vscodium # Text editor
    ../../pkgs/pomatez.nix
    ../../pkgs/mangohud.nix
    # ../../pkgs/editors/emacs # Another text editor
    # ../../pkgs/beekeeper-studio.nix # Database manager
    # ../../pkgs/lutris.nix
    # ../../pkgs/obs-studio.nix # Screen recording
    # ../../pkgs/mangohud.nix # Performance overlay for games
    # ../../pkgs/psst.nix # Spotify client (currently broken)
    ../../pkgs/gtk.nix
    ../../pkgs/qt.nix

    # Games
    # ../../pkgs/games/dwarf-fortress
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [ "wlr/workspaces" "wlr/taskbar" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "clock" "bluetooth" "cpu" "memory" "tray" ];

        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
          sort-by-number = true;
          all-outputs = true;
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };

        bluetooth = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        memory = {
          interval = 5;
          format = "{used:0.1f}G/{total:0.1f}G ";
        };

        cpu = {
          interval = 5;
          format = " {icon0} {icon1} {icon2} {icon3} {icon4} {icon5} {icon6} {icon7}";
          tooltip-format = "{usage}";
          format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
        };

        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,preferred,auto,auto
      
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      
      # Some default env vars.
      env = XCURSOR_SIZE,24

      exec-once = ${config.programs.waybar.package}/bin/waybar &
      
      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =
      
          follow_mouse = 1
      
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      
      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
      
          gaps_in = 0
          gaps_out = 0
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
      
          layout = dwindle
      }
      
      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
      
          rounding = 0
          blur = true
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = true
      
          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }
      
      animations {
          enabled = true
      
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
      
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }
      
      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }
      
      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }
      
      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = false
      }
      
      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = ALT
      
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, ${pkgs.xfce.thunar}/bin/thunar
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, R, exec, ${pkgs.wofi}/bin/wofi --show drun
      bind = $mainMod, P, pseudo, # dwindle
      # bind = $mainMod, J, togglesplit, # dwindle

      binde=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+

      # Example volume button that will activate even while an input inhibitor is active
      bindl=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

      bind = SUPER, c, exec, ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area
      
      # Move focus with mainMod + arrow keys
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d
      
      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10
      
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };

  fonts.fontconfig.enable = true;

  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = ":minimize,maximize,close";
    };
  };

  home.packages = cli ++ gui ++ games ++ proprietary ++ fonts;

  programs.bash.shellAliases = rebuild-alias;

  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
