{
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;

    settings = {
      # General
      general = {
        gaps_in = 8;
        gaps_out = 12;
        border_size = 2;
        layout = "dwindle";
        resize_on_border = true;
        allow_tearing = false;
      };

      # Decoration (visual effects)
      decoration = {
        rounding = 6;
        blur = {
          enabled = true;
          size = 4;
          passes = 2;
        };
        shadow = {
          enabled = true;
          range = 20;
          render_power = 2;
        };
      };

      # Animations
      animations = {
        enabled = true;
        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.0"
        ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Input
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        mouse_refocus = true;
        float_switch_override_focus = 2;
      };

      # Touchpad
      touchpad = {
        natural_scroll = false;
        disable_while_typing = true;
      };

      # Monitors
      monitor = [
        ",preferred,auto,auto"
      ];

      # Workspace configuration
      workspace = [
        "1, defaultName:1"
        "2, defaultName:2"
        "3, defaultName:3"
        "4, defaultName:4"
        "5, defaultName:5"
      ];

      # Misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };
    };

    # Hyprland keybindings
    bind = [
      # Applications
      "SUPER, RETURN, exec, kitty"
      "SUPER ALT, RETURN, exec, kitty -- tmux"
      "SUPER SHIFT, RETURN, exec, firefox"
      "SUPER SHIFT, F, exec, nautilus"
      "SUPER SHIFT, B, exec, firefox"
      "SUPER SHIFT, N, exec, codium"
      "SUPER SHIFT, M, exec, spotify"

      # Window management
      "SUPER, W, killactive"
      "SUPER, F, fullscreen, 0"
      "SUPER ALT, F, fullscreen, 1"
      "SUPER, T, togglefloating"
      "SUPER, J, togglesplit"
      "SUPER, P, pseudo"

      # Focus navigation
      "SUPER, LEFT, movefocus, l"
      "SUPER, RIGHT, movefocus, r"
      "SUPER, UP, movefocus, u"
      "SUPER, DOWN, movefocus, d"

      # Window movement
      "SUPER SHIFT, LEFT, movewindow, l"
      "SUPER SHIFT, RIGHT, movewindow, r"
      "SUPER SHIFT, UP, movewindow, u"
      "SUPER SHIFT, DOWN, movewindow, d"

      # Workspaces
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"

      # Tab/Cycle workspaces
      "SUPER, TAB, workspace, e+1"
      "SUPER SHIFT, TAB, workspace, e-1"

      # Utilities
      "SUPER, SPACE, exec, rofi -show drun"
      "SUPER, K, exec, rofi -show window"
      "SUPER, Q, killactive"
      "SUPER SHIFT, Q, exit"
      "SUPER ALT, L, exec, hyprlock"
      "PRINT, exec, grim -g \"$(slurp)\" - | wl-copy"
      "SUPER, PRINT, exec, grim -g \"$(slurp)\" - | wl-copy && notify-send 'Screenshot copied'"

      # Notifications
      "SUPER, COMMA, exec, makoctl dismiss"
      "SUPER SHIFT, COMMA, exec, makoctl dismiss --all"

      # System
      "SUPER ESCAPE, exec, rofi -show power-menu"
    ];

    # Mouse bindings
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };

  # Hypridle (idle management)
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # Hyprlock (lock screen)
  programs.hyprlock = {
    enable = true;
  };

  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
      path = screenshot
      blur_passes = 3
    }

    input-field {
      size = 250, 50
      outline_thickness = 3
      dots_center = true
      fade_on_empty = false
      font_color = rgb(200, 200, 200)
      inner_color = rgb(30, 30, 40)
      outer_color = rgb(80, 80, 100)
      check_color = rgb(100, 200, 255)
      fail_color = rgb(255, 100, 100)
      fail_text = <i>$ATTEMPTS</i> ($HELD - $ROUNDS ms)
      position = 0, 50
      halign = center
      valign = bottom
    }

    label {
      text = cmd[update:1000] echo "<b>$(date +%H:%M:%S)</b>"
      color = rgb(200, 200, 200)
      font_size = 64
      font_family = JetBrains Mono
      position = 0, -100
      halign = center
      valign = center
    }
  '';
}
