{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.killall;
in
{
  options.pi.shell.tools.killall = {
    enable = lib.mkEnableOption "Enable Killall tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        killall
      ];
    };
  };
}
