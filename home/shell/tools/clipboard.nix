{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.shell.tools.clipboard;
in
{
  options.pi.shell.tools.clipboard.enable = lib.mkEnableOption "clipboard";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      wl-clipboard-rs
    ];
  };
}
