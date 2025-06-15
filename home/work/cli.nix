{
  pkgs,
  lib,
  config,
  secrets,
  ...
}:

let
  cfg = config.pi.home.work.cli;
  cmd = secrets.personal.work.company;
in
{
  options.pi.home.work.cli = {
    enable = lib.mkEnableOption "Enable CLI configuration";
    cmd = lib.mkOption {
      type = lib.types.str;
      default = cmd;
      description = "Command to use for the CLI application";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      xdg.desktopEntries = {
        "${cmd}-cli" = {
          name = cmd + "-CLI";
          exec = cmd + " scheme %u";
          mimeType = [ ("x-scheme-handler/" + cmd) ];
          noDisplay = true;
          terminal = true;
          startupNotify = false;
        };
      };
    };
  };
}
