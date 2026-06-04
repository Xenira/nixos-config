{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.flamelens;
in
{
  options.pi.shell.tools.flamelens = {
    enable = lib.mkEnableOption "Enable flamelens tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        flamelens
      ];
    };
  };
}
