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

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd = {
          enable = true;
          enableXdgAutostart = true;
        };
        settings = {
          monitor = [
            ",preferred,auto,auto"
            "eDP-1,preferred,0x0,1"
          ];
          windowrulev2 = [
            "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
            "opacity 0.75 override 0.75 override,class:.*"
            "noblur,focus:0,class:.*"
          ];
          exec-once =
            [
              "dunst"
              "hyprpaper"
              "nm-applet --indicator & disown"
            ]
            ++ lib.optionals cfg.programs.vivaldi.enable [
              "vivaldi"
            ]
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
            kb_layout = "gb,gb";
            kb_variant = ",colemak_dh";
            kb_options = "compose:ralt";

            follow_mouse = 1;
            left_handed = 1;
          };

          general = {
            gaps_in = 4;
            gaps_out = 16;
            border_size = 2;
            "col.active_border" = "0xFFFFECFD";
            "col.inactive_border" = "0xFFEDFDFF";

            layout = "dwindle";
          };

          decoration = {
            rounding = 8;

            blur = {
              enabled = true;
              size = 8;
              passes = 3;
              ignore_opacity = true;
            };

            shadow = {
              enabled = true;
              offset = "0 0";
              range = 30;
              render_power = 2;
              ignore_window = 1;
              color = "0xFFAD0DED";
              color_inactive = "0xFF3292F3";
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
          bind =
            [
              "$mod, Return, exec, kitty"
              "$mod, Q, killactive"
              "$mod CTRL, Q, exit"
              "$mod, V, togglefloating"
              "$mod, T, fullscreen"
              "$mod, L, exec, hyprlock --immediate"
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
