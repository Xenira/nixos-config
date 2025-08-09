{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.dig;
in
{
  options.pi.shell.tools.dig = {
    enable = lib.mkEnableOption "Enable Falstfetch tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        dig
      ];
    };
  };
}
