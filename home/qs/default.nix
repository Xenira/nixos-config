{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.qs;
in
{
  options.pi.qs = {
    enable = lib.mkEnableOption "Enable qs configurations";
  };

  imports = [
  ];

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      # upower
    ];

    services.upower.enable = true;

    home-manager.users.ls = {
      programs = {
        quickshell = {
          enable = true;
          configs = {
            "default" = ./config;
          };
          activeConfig = "default";
        };
      };
    };
  };
}
