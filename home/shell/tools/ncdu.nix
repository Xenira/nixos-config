{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.ncdu;
in
{
  options.pi.shell.tools.ncdu = {
    enable = lib.mkEnableOption "Enable Ncdu tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        ncdu
      ];
    };
  };
}
