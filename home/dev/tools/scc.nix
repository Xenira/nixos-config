{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.dev.tools.scc;
in
{
  options.pi.dev.tools.scc.enable = lib.mkEnableOption "Enable scc";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      scc
    ];
  };
}
