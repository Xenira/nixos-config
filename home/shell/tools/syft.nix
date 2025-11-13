{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.shell.tools.syft;
in
{
  options.pi.shell.tools.syft.enable = lib.mkEnableOption "syft";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      syft
    ];
  };
}
