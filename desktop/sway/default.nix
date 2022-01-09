{ pkgs, colorscheme, lib, ... }:

let
  colorScheme = colorscheme.colors;

  kitty = "${pkgs.kitty}/bin/kitty";

  grimshot = "${pkgs.sway-contrib.grimshot}/bin/grimshot";
  mako = "${pkgs.mako}/bin/mako";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";

  wayab-pkg = pkgs.stdenv.mkDerivation {
    pname = "wayab";
    version = "unknown";

    src = pkgs.fetchFromGitHub {
      owner = "chux0519";
      repo = "0.1.0";
      rev = "6d12681e501d171a819fea1cefdcd65aea5feeb5";
      sha256 = "sha256-TxuT/xNUqZdLbMmoxD1a7CwmH3HeT7iJV8uWjPJXiNU=";
    };

    buildInputs = with pkgs; [
      egl-wayland
      wayland-protocols
      wayland
      cairo
    ];

    nativeBuildInputs = with pkgs; [
      cmake
      pkg-config
    ];

    buildPhase = ''
      cmake .
      make
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp wayab $out/bin
    '';
  };

  # swaybg = "${pkgs.swaybg}/bin/swaybg";
  oguri = "${pkgs.oguri}/bin/oguri";

  # Great GIFs here: https://1041uuu.tumblr.com/page/3
  background-gif = pkgs.fetchurl {
    url = "https://64.media.tumblr.com/2b0ec5e7d4763b0cc6aaba6982be379c/tumblr_inline_p46bi1Mmeq1qzc0ri_500.gifv";
    sha256 = "sha256-PiSyyBF5XQERvvUGGV8hkucSei6QPe9GElo9X8tjxOU=";
  };

  swayidle = "${pkgs.swayidle}/bin/swayidle";
  swaylock = lib.concatStringsSep " " [
    # TODO: Tweak these colors
    "${pkgs.swaylock}/bin/swaylock"
    "--color ${colorScheme.base00}"
    "--ring-color ${colorScheme.base01}"
    "--inside-color ${colorScheme.base02}"
    "--key-hl-color ${colorScheme.base08}"
    "--ring-ver-color ${colorScheme.base0B}"
    "--inside-ver-color ${colorScheme.base0C}"
    "--ring-wrong-color ${colorScheme.base09}"
    "--inside-wrong-color ${colorScheme.base0A}"
  ];
  waybar = "${pkgs.waybar}/bin/waybar";
  wofi = "${pkgs.wofi}/bin/wofi";

  switcher = pkgs.writeShellScriptBin "window-switcher" ''
    # ------Get available windows:
    windows=$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r '
      recurse(.nodes[]?) |
        recurse(.floating_nodes[]?) |
        select(.type=="con"), select(.type=="floating_con"), select(.length > 0) |
          (.id | tostring) + " " + .app_id + ": " + .name')

    # ------Limit wofi's height with the number of opened windows:
    height=$(echo "$windows" | wc -l)

    # ------Select window with wofi:
    selected=$(echo "$windows" | ${wofi} -d -i --lines "$height" -p "Switch to:" | awk '{print $1}')

    # ------Tell sway to focus said window:
    ${pkgs.sway}/bin/swaymsg [con_id="$selected"] focus
  '';

  wallpaper = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath}";
in
{
  imports = [
    ../../pkgs/mako.nix
    ../../pkgs/kitty.nix
  ];

  xdg.configFile."oguri/config".text = ''
    [output HDMI-A-1]
    image=${background-gif}
    filter=nearest
    scaling-mode=fill
    anchor=center
  '';

  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
    extraOptions = [
      "--unsupported-gpu"
    ];
    config = rec {
      modifier = "Mod1"; # Alt
      terminal = "${kitty}";
      menu =
        "${wofi} -D run-always_parse_args=true -i -M fuzzy -S run -t ${terminal}";
      colors = {
        focused = {
          border = "${colorScheme.base0C}";
          background = "${colorScheme.base00}";
          text = "${colorScheme.base05}";
          indicator = "${colorScheme.base09}";
          childBorder = "${colorScheme.base0C}";
        };
        focusedInactive = {
          border = "${colorScheme.base03}";
          background = "${colorScheme.base00}";
          text = "${colorScheme.base04}";
          indicator = "${colorScheme.base03}";
          childBorder = "${colorScheme.base03}";
        };
        unfocused = {
          border = "${colorScheme.base02}";
          background = "${colorScheme.base00}";
          text = "${colorScheme.base03}";
          indicator = "${colorScheme.base02}";
          childBorder = "${colorScheme.base02}";
        };
        urgent = {
          border = "${colorScheme.base09}";
          background = "${colorScheme.base00}";
          text = "${colorScheme.base03}";
          indicator = "${colorScheme.base09}";
          childBorder = "${colorScheme.base09}";
        };
      };
      bars = [ ];
      window = {
        border = 2;
        commands = [
          # {
          #   command = "move scratchpad";
          #   criteria = { title = "Wine System Tray"; };
          # }
          {
            # command = "move scratchpad";
            command = "kill";
            criteria = { title = "Firefox — Sharing Indicator"; };
          }
        ];
      };
      startup = [
        # { command = "${swaybg} -i ${wallpaper} -m fill"; }
        # { command = "${swayidle} -w"; }
        { command = "${oguri}"; }
        { command = "${waybar}"; }
        { command = "${mako}"; }
      ];
      keybindings = lib.mkOptionDefault {
        "${modifier}+d" = "exec ${grimshot} --notify copy area";
        "${modifier}+shift+d" = "exec ${grimshot} --notify copy window";
        "${modifier}+control+d" = "exec ${grimshot} --notify copy screen";
        "${modifier}+p" = "exec ${menu}";
        "${modifier}+a" = "exec ${terminal}";
        "${modifier}+s" = "exec ${switcher}/bin/window-switcher";
        "${modifier}+c" = "kill";
        "${modifier}+control+l" = "exec ${swaylock}";
        "${modifier}+tab" = "workspace back_and_forth";
        "${modifier}+minus" = "opacity minus 0.1";
        "${modifier}+equal" = "opacity plus 0.1";
      };
    };
    extraConfig = ''
      set $opacity 0.9
      for_window [class=".*"] opacity $opacity
      for_window [app_id=".*"] opacity $opacity

      hide_edge_borders --i3 smart
    '';
  };

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "bottom";
        height = 5;
        position = "bottom";
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        # modules-center = [ "sway/window" ];
        modules-right = [
          "pulseaudio"
          "custom/separator"
          "disk"
          "custom/separator"
          "cpu"
          "custom/separator"
          "memory"
          "clock"
          "tray"
        ];
        modules = {
          battery = {
            bat = "BAT0";
            interval = 40;
            format = "BAT {capacity}%";
            format-charging = "CHR {capacity}%";
          };
          "custom/separator" = {
            format = "|";
            interval = "once";
            tooltip = false;
          };
          clock = {
            format = "{:%d/%m %H:%M}";
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>
            '';
          };
          cpu = {
            format = "CPU {usage}% - {avg_frequency}Ghz";
            interval = 1;
            tooltip = false;
          };
          disk = {
            format = "DISK {used}/{total}";
            tooltip = false;
          };
          memory = { format = "RAM {used:0.1f}G/{total:0.1f}G "; };
          pulseaudio = {
            format = "VOL {volume}%";
            format-muted = "MUTE";
            on-click = "${pavucontrol}";
          };
        };
      }
    ];
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Jetbrains Mono;
        font-size: 12px;
        margin: 0px 0;
        padding: 0 3px;
      }
      window#waybar {
        color: #${colorScheme.base05};
        background-color: #${colorScheme.base00};
        border-bottom: 2px solid #${colorScheme.base0C};
      }
      #workspaces button {
        margin: 0;
      }
      #workspaces button.visible,
      #workspaces button.focused {
        background-color: #${colorScheme.base01};
        color: #${colorScheme.base04};
      }
      #workspaces button.focused {
        color: #${colorScheme.base0A};
      }
      #pulseaudio {
        padding: 0 8px;
      }
      #clock {
        background-color: #${colorScheme.base0C};
        color: #${colorScheme.base00};
        margin: 0;
        padding: 0 12px;
      }
    '';
  };

  # swaylock
  xdg.configFile."swaylock/config".text = ''
    effect-blur=20x3
    fade-in=0.1
    font=Fira Sans
    font-size=15
    line-uses-inside
    disable-caps-lock-text
    indicator-caps-lock
    indicator-radius=40
    indicator-idle-visible
    indicator-y-position=1000
    ring-color=#${colorScheme.base02}
    inside-wrong-color=#${colorScheme.base08}
    ring-wrong-color=#${colorScheme.base08}
    key-hl-color=#${colorScheme.base0B}
    bs-hl-color=#${colorScheme.base08}
    ring-ver-color=#${colorScheme.base09}
    inside-ver-color=#${colorScheme.base09}
    inside-color=#${colorScheme.base01}
    text-color=#${colorScheme.base07}
    text-clear-color=#${colorScheme.base01}
    text-ver-color=#${colorScheme.base01}
    text-wrong-color=#${colorScheme.base01}
    text-caps-lock-color=#${colorScheme.base07}
    inside-clear-color=#${colorScheme.base0C}
    ring-clear-color=#${colorScheme.base0C}
    inside-caps-lock-color=#${colorScheme.base09}
    ring-caps-lock-color=#${colorScheme.base02}
    separator-color=#${colorScheme.base02}
  '';

  xdg.configFile."wofi/style.css".text = ''
    window {
      margin: 0px;
      border: 1px solid #${colorScheme.base0C};
      background-color: #${colorScheme.base00};
    }
    #input {
      margin: 5px;
      border: none;
      color: #${colorScheme.base05};
      background-color: #${colorScheme.base02};
    }
    #inner-box {
      margin: 5px;
      border: none;
      background-color: #${colorScheme.base00};
    }
    #outer-box {
      margin: 5px;
      border: none;
      background-color: #${colorScheme.base00};
    }
    #scroll {
      margin: 0px;
      border: none;
    }
    #text {
      margin: 5px;
      border: none;
      color: #${colorScheme.base05};
    }
    #entry:selected {
      background-color: #${colorScheme.base02};
    }
  '';

  home.packages = with pkgs; [
    wl-clipboard
    libnotify
  ];
}
