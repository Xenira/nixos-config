{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.openapi-tui;
in
{
  options.pi.shell.tools.openapi-tui = {
    enable = lib.mkEnableOption "Enable openapi-tui tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        openapi-tui
      ];
    };
  };
}
