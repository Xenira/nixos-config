{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.traceroute;
in
{
  options.pi.shell.tools.traceroute = {
    enable = lib.mkEnableOption "Enable Falstfetch tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = [ pkgs.traceroute ];
    };
  };
}
