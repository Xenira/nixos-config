{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.shell.tools.yubico-piv-tool;
in
{
  options.pi.shell.tools.yubico-piv-tool = {
    enable = lib.mkEnableOption "Enable yubico-piv-tool tool";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        yubico-piv-tool
        libp11
      ];
    };
  };
}
