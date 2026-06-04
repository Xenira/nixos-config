{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi;
in
{
  options.pi = {
    work.enable = lib.mkEnableOption "Enable work configuration";
    desktop.enable = lib.mkEnableOption "Enable desktop configuration";
    server.enable = lib.mkEnableOption "Enable server configuration";
  };

  config = {
    pi = {
      desktop.enable = lib.mkDefault (!cfg.server.enable);
      dev.enable = lib.mkDefault true;
      font.enable = lib.mkDefault cfg.desktop.enable;
      git.enable = lib.mkDefault true;
      home.work.enable = lib.mkDefault cfg.work.enable;
      hypr.enable = lib.mkDefault cfg.desktop.enable;
      niri.enable = lib.mkDefault cfg.desktop.enable;
      nvim.enable = lib.mkDefault true;
      programs.enable = lib.mkDefault cfg.desktop.enable;
      qs.enable = lib.mkDefault cfg.desktop.enable;
      server.enable = lib.mkDefault false;
      shell.enable = lib.mkDefault true;
      ssh.enable = lib.mkDefault true;
      work.enable = lib.mkDefault true;
      xdg.enable = lib.mkDefault true;
      # hypr.waybar.enable = lib.mkDefault (cfg.desktop.enable && !cfg.qs.enable);

      # Custom Global Overrides
    };
  };
}
