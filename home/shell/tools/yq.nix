{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.yq;
in
{
  options.pi.shell.tools.yq = {
    enable = lib.mkEnableOption "Enable yq tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = [
        pkgs.yq-go
      ];
    };
  };
}
