{ pkgs, ... }:

{
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
        modules-right = [ "network" "clock" "bluetooth" "cpu" "memory" "tray" ];

        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            urgent = "";
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

        network = {
          interval = 5;
          format-ethernet = " {ipaddr}/{cidr}"; # Icon: ethernet
          format-disconnected = "⚠  Disconnected";
          tooltip-format = ": {bandwidthDownBytes} : {bandwidthUpBytes}";
        };

        bluetooth = {
          format = "  {status} ";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
        };

        memory = {
          interval = 5;
          format = "  {}%";
          states = {
            warning = 70;
            critical = 90;
          };
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
    style = ''
            * {
                /* `otf-font-awesome` is required to be installed for icons */
                font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
                font-size: 13px;
            }
      
            window#waybar {
                background-color: rgba(43, 48, 59, 0.5);
                border-bottom: 3px solid rgba(100, 114, 125, 0.5);
                color: #ffffff;
                transition-property: background-color;
                transition-duration: .5s;
            }
      
            window#waybar.hidden {
                opacity: 0.2;
            }
      
            /*
            window#waybar.empty {
                background-color: transparent;
            }
            window#waybar.solo {
                background-color: #FFFFFF;
            }
            */
      
            window#waybar.termite {
                background-color: #3F3F3F;
            }
      
            window#waybar.chromium {
                background-color: #000000;
                border: none;
            }
      
            button {
                /* Use box-shadow instead of border so the text isn't offset */
                box-shadow: inset 0 -3px transparent;
                /* Avoid rounded borders under each button name */
                border: none;
                border-radius: 0;
            }
      
            /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
            button:hover {
                background: inherit;
                box-shadow: inset 0 -3px #ffffff;
            }
      
            #workspaces button {
                padding: 0 5px;
                background-color: transparent;
                color: #ffffff;
            }

            #workspaces button.active {
              color: #38d96b;
            }
      
            #workspaces button:hover {
                background: rgba(0, 0, 0, 0.2);
            }
      
            #workspaces button.focused {
                background-color: #64727D;
                box-shadow: inset 0 -3px #ffffff;
            }
      
            #workspaces button.urgent {
                background-color: #eb4d4b;
            }
      
            #mode {
                background-color: #64727D;
                border-bottom: 3px solid #ffffff;
            }
      
            #clock,
            #battery,
            #cpu,
            #memory,
            #disk,
            #temperature,
            #backlight,
            #network,
            #pulseaudio,
            #wireplumber,
            #custom-media,
            #tray,
            #mode,
            #idle_inhibitor,
            #scratchpad,
            #mpd {
                padding: 0 10px;
                color: #ffffff;
            }
      
            #window,
            #workspaces {
                margin: 0 4px;
            }
      
            /* If workspaces is the leftmost module, omit left margin */
            .modules-left > widget:first-child > #workspaces {
                margin-left: 0;
            }
      
            /* If workspaces is the rightmost module, omit right margin */
            .modules-right > widget:last-child > #workspaces {
                margin-right: 0;
            }
      
            #clock {
                background-color: #64727D;
            }
      
            #battery {
                background-color: #ffffff;
                color: #000000;
            }
      
            #battery.charging, #battery.plugged {
                color: #ffffff;
                background-color: #26A65B;
            }
      
            @keyframes blink {
                to {
                    background-color: #ffffff;
                    color: #000000;
                }
            }
      
            #battery.critical:not(.charging) {
                background-color: #f53c3c;
                color: #ffffff;
                animation-name: blink;
                animation-duration: 0.5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
            }
      
            label:focus {
                background-color: #000000;
            }
      
            #cpu {
                background-color: #2ecc71;
                color: #000000;
            }
      
            #memory {
                background-color: #9b59b6;
            }
      
            #disk {
                background-color: #964B00;
            }
      
            #backlight {
                background-color: #90b1b1;
            }
      
            #network {
                background-color: #2980b9;
            }
      
            #network.disconnected {
                background-color: #f53c3c;
            }
      
            #pulseaudio {
                background-color: #f1c40f;
                color: #000000;
            }
      
            #pulseaudio.muted {
                background-color: #90b1b1;
                color: #2a5c45;
            }
      
            #wireplumber {
                background-color: #fff0f5;
                color: #000000;
            }
      
            #wireplumber.muted {
                background-color: #f53c3c;
            }
      
            #custom-media {
                background-color: #66cc99;
                color: #2a5c45;
                min-width: 100px;
            }
      
            #custom-media.custom-spotify {
                background-color: #66cc99;
            }
      
            #custom-media.custom-vlc {
                background-color: #ffa000;
            }
      
            #temperature {
                background-color: #f0932b;
            }
      
            #temperature.critical {
                background-color: #eb4d4b;
            }
      
            #tray {
                background-color: #2980b9;
            }
      
            #tray > .passive {
                -gtk-icon-effect: dim;
            }
      
            #tray > .needs-attention {
                -gtk-icon-effect: highlight;
                background-color: #eb4d4b;
            }
      
            #idle_inhibitor {
                background-color: #2d3436;
            }
      
            #idle_inhibitor.activated {
                background-color: #ecf0f1;
                color: #2d3436;
            }
      
            #mpd {
                background-color: #66cc99;
                color: #2a5c45;
            }
      
            #mpd.disconnected {
                background-color: #f53c3c;
            }
      
            #mpd.stopped {
                background-color: #90b1b1;
            }
      
            #mpd.paused {
                background-color: #51a37a;
            }
      
            #language {
                background: #00b093;
                color: #740864;
                padding: 0 5px;
                margin: 0 5px;
                min-width: 16px;
            }
      
            #keyboard-state {
                background: #97e1ad;
                color: #000000;
                padding: 0 0px;
                margin: 0 5px;
                min-width: 16px;
            }
      
            #keyboard-state > label {
                padding: 0 5px;
            }
      
            #keyboard-state > label.locked {
                background: rgba(0, 0, 0, 0.2);
            }
      
            #scratchpad {
                background: rgba(0, 0, 0, 0.2);
            }
      
            #scratchpad.empty {
      	      background-color: transparent;
            }
    '';
  };
}
