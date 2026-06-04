{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "graphical-session.target";

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 26;
        spacing = 0;
        reload_style_on_change = true;

        modules-left = [
          "custom/logo"
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "bluetooth"
          "network"
          "pulseaudio"
          "cpu"
          "battery"
          "tray"
        ];

        # Workspaces
        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            active = "󱓻";
            default = "";
          };
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        # Custom logo/menu
        "custom/logo" = {
          format = "◆";
          on-click = "rofi -show drun";
          tooltip = "Omarchy Menu";
        };

        # Clock
        clock = {
          format = "{:%a %H:%M}";
          format-alt = "{:%d %B W%V %Y}";
          tooltip = false;
        };

        # Network
        network = {
          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰤮";
          tooltip-format-wifi = "{essid} ({frequency} GHz)";
          tooltip-format-ethernet = "Connected";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          on-click = "networkmanager_dmenu";
        };

        # Battery
        battery = {
          format = "{capacity}% {icon}";
          format-discharging = "{icon}";
          format-charging = "{icon}";
          format-plugged = "";
          format-icons = {
            charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
            default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          format-full = "󰂅";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
        };

        # Bluetooth
        bluetooth = {
          format = "";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-no-controller = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "bluetooth-manager";
        };

        # Audio
        pulseaudio = {
          format = "{icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            headset = "";
            default = ["" "" ""];
          };
          scroll-step = 5;
          on-click = "pavucontrol";
        };

        # CPU
        cpu = {
          interval = 5;
          format = "󰍛 {usage}%";
          on-click = "kitty -- btop";
        };

        # Tray
        tray = {
          icon-size = 12;
          spacing = 17;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrains Mono Nerd Font";
        font-size: 12px;
        color: #cdd6f4;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.9);
        border-bottom: 1px solid rgba(108, 112, 134, 0.5);
        padding: 0px;
        margin: 0px;
      }

      #custom-logo,
      #hyprland-workspaces,
      #clock,
      #network,
      #bluetooth,
      #pulseaudio,
      #cpu,
      #battery,
      #tray {
        padding: 0px 8px;
        margin: 0px 0px;
      }

      #hyprland-workspaces button {
        border-radius: 4px;
        padding: 0px 8px;
        margin: 4px 4px;
        background-color: rgba(108, 112, 134, 0.2);
        color: #cdd6f4;
      }

      #hyprland-workspaces button.active {
        background-color: rgba(94, 165, 207, 0.8);
        color: #1e1e2e;
      }

      #hyprland-workspaces button:hover {
        background-color: rgba(94, 165, 207, 0.5);
      }

      #clock {
        font-weight: bold;
      }

      #network.wifi {
        color: #a6e3a1;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #battery.charging {
        color: #a6e3a1;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }

      #pulseaudio {
        color: #b4befe;
      }

      #pulseaudio.muted {
        color: #f38ba8;
      }

      #cpu {
        color: #fab387;
      }
    '';
  };
}
