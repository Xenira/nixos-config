{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.dev.tools.tilt;
in
{
  options.pi.dev.tools.tilt.enable = lib.mkEnableOption "Enable tilt";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      tilt
    ];
  };
}
