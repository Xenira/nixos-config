{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.shell.tools.sops;
in
{
  options.pi.shell.tools.sops.enable = lib.mkEnableOption "sops";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      sops
    ];
  };
}
