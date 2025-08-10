{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.hypr.waybar = {
    enable = lib.mkEnableOption "Enable Waybar configuration for Hyprland";
  };

  config = lib.mkIf config.pi.hypr.waybar.enable {
    home-manager.users.ls = {
      programs.waybar = {
        enable = true;
        systemd.enable = false;
        settings = [
          {
            layer = "top";
            height = 30;
            spacing = 6;
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [
              "clock"
              "privacy"
            ];
            modules-right =
              lib.optionals config.pi.home.work.cli.enable [
                "custom/status"
              ]
              ++ [
                "network"
                "wireplumber"
                "battery"
                "tray"
              ];
            tray.spacing = 10;
            clock = {
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format = "{:%H:%M:%S}";
              format-alt = "{:%Y-%m-%d}";
              interval = 1;
            };
            battery = {
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{capacity}% {icon}";
              format-charging = "{capacity}% ";
              format-plugged = "{capacity}% ";
              format-alt = "{time} {icon}";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
              ];
            };
            network = {
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "{ipaddr}/{cidr} ";
              tooltip-format = "{ifname} via {gwaddr} ";
              format-linked = "{ifname} (No IP) ";
              format-disconnected = "Disconnected ⚠";
              format-alt = "{ifname}: {ipaddr}/{cidr}";
            };
            privacy = {
              icon-spacing = 4;
              icon-size = 18;
              transition-duration = 250;
              modules = [
                {
                  type = "screenshare";
                  tooltip = true;
                  tooltip-icon-size = 24;
                }
                {
                  type = "audio-out";
                  tooltip = true;
                  tooltip-icon-size = 24;
                }
                {
                  type = "audio-in";
                  tooltip = true;
                  tooltip-icon-size = 24;
                }
              ];
            };
            wireplumber = {
              format = " {volume}%  ";
              format-muted = "{node_name} ";
              on-click = "pavucontrol";
            };
            "custom/status" = lib.mkIf config.pi.home.work.cli.enable {
              interval = 30;
              exec = config.pi.home.work.cli.cmd + " --non-interactive status -o short";
            };
          }
        ];
        style = ''
          @import url("colors.css");
          * {
            border: none;
            border-radius: 0;
            font-family: Roboto, Helvetica, Arial, sans-serif;
            font-size: 13px;
            min-height: 0;
          }

          window#waybar {
            background: alpha(@background, 0.5);
            border-bottom: 2px solid @color1;
            color: @foreground;
          }

          tooltip {
            background: alpha(@background, 0.5);
            border: 1px solid @color2;
          }

          tooltip label {
            color: white;
          }

          #workspaces button {
                padding: 0 1rem;
                background: transparent;
                color: @foreground;
                border-bottom: 3px solid transparent;
              }

          #workspaces button.focused {
                background: @foreground;
                color: @background;
                border-bottom: 3px solid white;
              }

          #mode,
          #clock,
          #battery {
                padding: 0 10px;
              }

          #mode {
                background: #64727D;
                border-bottom: 3px solid white;
              }

          #clock {
                background-color: alpha(@color4, 0.6);
              }

          #battery {
                background-color: #ffffff;
                color: black;
              }

          #battery.charging {
                color: white;
                background-color: #26A65B;
              }

              @keyframes blink {
                to {
                  background-color: #ffffff;
                  color: black;
                }
              }

          #battery.warning:not(.charging) {
                background: #f53c3c;
                color: white;
                animation-name: blink;
                animation-duration: 0.5s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
              }
        '';
      };
    };
  };
}
