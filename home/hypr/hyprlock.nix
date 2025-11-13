{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.hypr.hyprlock = {
    enable = lib.mkEnableOption "Enable Hypridle configuration";
  };

  config = lib.mkIf config.pi.hypr.hyprlock.enable {
    home-manager.users.ls = {
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            hide_cursor = true;
            immediate_render = true;
          };

          animations = {
            enabled = true;
            fade_in = {
              duration = 300;
              bazier = "easeOutQuint";
            };
            fade_out = {
              duration = 300;
              bazier = "easeOutQuint";
            };
          };

          auth = {
            "pam:module" = "login";
          };

          background = {
            monitor = "";
            path = "screenshot";
            blur_passes = 4;
            blur_size = 7;
          };

          label = [
            {
              text = "cmd[update:1000] echo \"$(date +%H:%M:%S)\"";
              font_size = 40;
              halign = "center";
              valign = "center";
            }
            {
              text = "cmd[update:1000] echo \"$PAMPROMPT $PAMFAIL\"";
              font_size = 20;
              halign = "center";
              valign = "bottom";
            }
          ];
        };
      };
    };
  };
}
