{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.inotify-tools;
in
{
  options.pi.shell.tools.inotify-tools = {
    enable = lib.mkEnableOption "Enable Inotify Tools";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        inotify-tools
      ];
    };
  };
}
