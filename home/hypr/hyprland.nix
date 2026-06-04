{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.pi;
in
{
  options.pi.hypr.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland configuration";
  };

  config = lib.mkIf cfg.hypr.hyprland.enable {
    programs.hyprland.enable = true;

    home-manager.users.ls = {
      home.sessionVariables.NIXOS_OZONE_WL = "1";
      services.awww = {
        enable = true;
      };
      systemd.user = {
        services.background-img = {
          Unit = {
            Description = "Set background image";
            After = [ "network.target" ];
          };
          Service = {
            Type = "oneshot";
            ExecStart = toString (
              pkgs.writeShellScript "set-background" ''
                #!/bin/bash
                set -e

                # IMAGE="$(ls ~/Pictures/Wallpapers | shuf -n 1)"
                IMAGE="$(unsplash)"
                rm -rf /home/ls/.cache/wallust
                wallust run $IMAGE
                awww img $IMAGE
              ''
            );
          };
          Install.WantedBy = [ "default.target" ];
        };
        timers.background-img = {
          Unit = {
            Description = "Run background image service every 15 minutes";
          };
          Timer = {
            OnBootSec = "15min";
            OnUnitActiveSec = "15min";
          };
          Install.WantedBy = [ "timers.target" ];
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        configType = "hyprlang";
        systemd = {
          enable = true;
          enableXdgAutostart = true;
        };
        settings = {
          source = [
            "~/.config/hyprscreen/hyprland.conf"
          ]
          ++ lib.optionals (config.pi.shell.tools.wallust.enable) [
            "~/.config/wallust/templates/hyprland.conf"
          ];
          monitor = [
            ",preferred,auto,auto"
            "eDP-1,preferred,0x0,1"
            "HDMI-A-2,preferred,auto,1,bitdepth,10,cm,hdr,vrr,1"
          ];
          workspace = [
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
          ];
          windowrule = [
            # smart gaps
            {
              name = "Smart Gaps TV";
              "match:float" = 0;
              "match:workspace" = "w[tv1]";
              rounding = 0;
              border_size = 0;
            }
            {
              name = "Smart Gaps Maximized";
              "match:float" = 0;
              "match:workspace" = "f[1]";
              rounding = 0;
              border_size = 0;
            }
            # "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
            {
              name = "Float Polkit";
              "match:class" = "^(org.kde.polkit-kde-authentication-agent-1)$";
              float = "on";
              focus_on_activate = "on";
            }
            {
              name = "Opacity";
              "match:class" = ".*";
              opacity = "0.75 0.75";
            }
            {
              name = "No Blur on Focus";
              "match:focus" = 0;
              "match:class" = ".*";
              no_blur = "on";
            }
            {
              name = "No Opacity on floating";
              "match:float" = 1;
              "match:class" = ".*";
              opacity = "1.0 1.0";
            }
          ];
          exec = [
            # "pkill waybar; waybar &"
            # "hyprscreen"
          ];
          exec-once = [
            "qs -d"
            "hyprpaper"
            "nm-applet --indicator & disown"
          ]
          # ++ lib.optionals cfg.programs.vivaldi.enable [
          #   "vivaldi"
          # ]
          ++ lib.optionals cfg.programs.nheko.enable [
            "nheko"
          ]
          ++ lib.optionals false [
            "steam"
          ]
          ++ lib.optionals cfg.programs.thunderbird.enable [
            "thunderbird"
          ];
          input = {
            kb_layout = "gb,us";
            kb_variant = ",colemak_dh";
            kb_options = "grp:win_space_toggle";

            follow_mouse = 1;
            left_handed = 1;
          };

          general = {
            gaps_in = 2;
            gaps_out = 8;
            border_size = 3;
            "col.active_border" = lib.mkIf (!config.pi.shell.tools.wallust.enable) "0xFFFFECFD";
            "col.inactive_border" = lib.mkIf (!config.pi.shell.tools.wallust.enable) "0xFFEDFDFF";

            layout = "dwindle";
          };

          decoration = {
            rounding = 8;

            blur = {
              enabled = true;
              size = 8;
              passes = 3;
              ignore_opacity = true;
              # new_optimizations = false;
            };

            shadow = {
              enabled = true;
              offset = "0 0";
              range = 30;
              render_power = 2;
              # ignore_window = 1; # FIXME: Investigate removal
              color = lib.mkIf (!config.pi.shell.tools.wallust.enable) "0xFFAD0DED";
              color_inactive = lib.mkIf (!config.pi.shell.tools.wallust.enable) "0xFF3292F3";
            };
          };

          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 7, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "borderangle, 1, 8, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };

          "$mod" = "SUPER";
          bind = [
            "$mod, Return, exec, kitty"
            "$mod, Q, killactive"
            "$mod CTRL, Q, exit"
            "$mod, V, togglefloating"
            "$mod, T, fullscreen"
            "$mod, L, exec, hyprlock --grace 0"
            "$mod CTRL, R, exec, hyprctl reload"
            "$mod, A, exec, tofi-drun --drun-launch=true"
            "$mod, E, exec, thunar"
            "$mod CTRL, 0, exec, hyprscreen"
            "$mod, F, movefocus, l"
            "$mod, H, movefocus, r"
            "$mod, P, movefocus, u"
            "$mod, D, movefocus, d"
            "$mod CTRL, F, movewindow, l"
            "$mod CTRL, H, movewindow, r"
            "$mod CTRL, P, movewindow, u"
            "$mod CTRL, D, movewindow, d"
          ]
          ++ (
            # workspaces
            # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
            builtins.concatLists (
              builtins.genList (
                i:
                let
                  ws = i + 1;
                in
                [
                  "$mod, code:1${toString i}, workspace, ${toString ws}"
                  "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
                ]
              ) 9
            )
          );

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}
