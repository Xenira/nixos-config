{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.lychee;
in
{
  options.pi.shell.tools.lychee = {
    enable = lib.mkEnableOption "Enable lychee tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        lychee
      ];
    };
  };
}
