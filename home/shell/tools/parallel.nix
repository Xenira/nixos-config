{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.parallel;
in
{
  options.pi.shell.tools.parallel = {
    enable = lib.mkEnableOption "Enable parallel tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        parallel
      ];
    };
  };
}
