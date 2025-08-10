{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.wallust;
in
{
  options.pi.shell.tools.wallust = {
    enable = lib.mkEnableOption "Enable wallust theming tool";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.wallust = {
        enable = true;
        settings = {
          backend = "full";
          check_contrast = true;
          templates = {
            niri = lib.mkIf (config.pi.niri.enable) {
              template = ./niri.kdl;
              target = "~/.config/wallust/templates/niri.sh";
            };
            hyprland = lib.mkIf (config.pi.hypr.hyprland.enable) {
              template = ./hyprland.conf;
              target = "~/.config/wallust/templates/hyprland.conf";
            };
            kitty = lib.mkIf (config.pi.shell.kitty.enable) {
              template = ./kitty.conf;
              target = "~/.config/wallust/templates/kitty.conf";
            };
            waybar = lib.mkIf (config.pi.hypr.waybar.enable) {
              template = ./waybar.css;
              target = "~/.config/waybar/colors.css";
            };
          };
        };
      };
    };
  };
}
