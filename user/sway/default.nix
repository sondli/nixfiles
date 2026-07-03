{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    sway
    imv
    grim
    slurp
    wl-clipboard
    mako
    bemenu
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      terminal = "foot";
      modifier = "Mod4";
      menu = "bemenu-run";
      defaultWorkspace = "workspace number 1";
      window = {
        titlebar = false;
      };
      output = {
        DP-1 = {
          mode = "3440x1440@180hz";
        };
      };
      bars = [ ];
      input = {
        "*" = {
          xkb_layout = "us,no";
        };
        "type:pointer" = {
          accel_profile = "flat";
        };
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "Mod1+Shift+u" = "exec grim - | wl-copy";
          "Mod1+Shift+y" = ''exec grim -g "$(slurp)" - | wl-copy'';
          "Mod1+Shift+p" = "exec swaymsg input type:keyboard xkb_switch_layout next";
        };
    };

    extraConfig = ''
            bar { 
                swaybar_command waybar
            }

      			input type:keyboard xkb_numlock enabled
    '';
  };

  services.mako.enable = true;

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 30;
        spacing = 4;

        modules-left = [
          "pulseaudio"
          "cpu"
          "memory"
          "network"
          "backlight"
          "battery"
					"custom/planner"
        ];
        modules-center = [ "sway/workspaces" ];
        modules-right = [
          "tray"
          "sway/language"
          "clock"
        ];

        tray = {
          #"icon-size" = 21;
          "spacing" = 10;
        };
        clock = {
          "interval" = 1;
          "format" = "{:%H:%M %Y-%m-%d %a} ";
          "timezone" = "Europe/Bucharest";
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        cpu = {
          "format" = "   {usage}%";
        };
        memory = {
          "format" = "   {}%";
        };
        backlight = {
          "format" = "{icon}  {percent}%";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
            ""
          ];
        };
        battery = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{icon}  {capacity}%";
          "format-charging" = "  {capacity}%";
          "format-plugged" = "  {capacity}%";
          #"format-good" = ""; # An empty format will hide the module
          #"format-full" = "";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "sway/language" = {
          "format" = "{}";
          "on-click" = "swaymsg input type:keyboard xkb_switch_layout next";
        };

        pulseaudio = {
          "scroll-step" = 1;
          "format" = " {icon}   {volume}% {desc}";
          "format-bluetooth" = "{icon}  {volume}%  {format_source}";
          "format-bluetooth-muted" = "󰸈 {icon}  {format_source}";
          "format-muted" = "󰸈 {format_source}";
          #"format-source" = "{volume}% ";
          #"format-source-muted" = " ";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "exec pavucontrol";
          "on-click-right" = "exec ~/.config/nixos/scripts/rotate-auto-output.sh";
        };
        network = {
          "interface" = "wlp16s0u5";
          "format" = "{ifname}";
          "format-wifi" = "   ({signalStrength}%) ";
          "format-ethernet" = "{ipaddr}/{cidr} 󰊗";
          "format-disconnected" = "";
          "tooltip-format" = "{ifname} via {gwaddr} 󰊗";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) ";
          "tooltip-format-ethernet" = "{ifname} ";
          "tooltip-format-disconnected" = "Disconnected";
          "max-length" = 50;
        };
        "custom/planner" = {
          exec = "~/.config/nixos/scripts/planner-health.sh";
          return-type = "json";
          interval = 60;
          format = "{}";
        };
      };
    };
    style = ''
      #custom-planner.healthy {
          color: #a6e3a1;
      }

      #custom-planner.unhealthy {
          color: #f38ba8;
      }

      #custom-planner.error {
          color: #fab387;
      }
      		'';
  };
}
