{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.tailspin;
in
{
  options.pi.shell.tools.tailspin = {
    enable = lib.mkEnableOption "Enable tailspin tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        tailspin
      ];
    };
  };
}
