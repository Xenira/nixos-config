{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.dev.tools.valgrind;
in
{
  options.pi.dev.tools.valgrind.enable = lib.mkEnableOption "Enable valgrind";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      valgrind
    ];
  };
}
