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
      work.enable = lib.mkDefault true;
      server.enable = lib.mkDefault false;
      desktop.enable = lib.mkDefault (!cfg.server.enable);
      home.work.enable = lib.mkDefault cfg.work.enable;
      programs.enable = lib.mkDefault cfg.desktop.enable;
      hypr.enable = lib.mkDefault cfg.desktop.enable;
      nvim.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      dev.enable = lib.mkDefault true;
      xdg.enable = lib.mkDefault true;
      shell.enable = lib.mkDefault true;

      # Custom Global Overrides
    };
  };
}
