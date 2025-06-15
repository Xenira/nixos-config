{ pkgs, lib, config, ... }:

let
  cfg = config.pi.hypr.hypridle;
in {
  options.pi.hypr.hypridle = {
    enable = lib.mkEnableOption "Enable Hypridle configuration";
    timeout = lib.mkOption {
      type = lib.types.int;
      default = 300;
      description = "Sets the time in seconds until the screen is locked";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
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
              timeout = cfg.timeout - 30;
              on-timeout = "brightnessctl -s set 10";
              on-resume = "brightnessctl -r";
            }
            {
              timeout = cfg.timeout;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = cfg.timeout + 30;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ];
        };
      };
    };
  };
}
