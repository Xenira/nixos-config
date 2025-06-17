{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.fastfetch;
in
{
  options.pi.shell.tools.fastfetch = {
    enable = lib.mkEnableOption "Enable Falstfetch tool";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.fastfetch = {
        enable = true;
      };
    };
  };
}
