{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.programs.thunar;
in
{
  options.pi.programs.thunar.enable = lib.mkEnableOption "Enable thunar configuration";

  config = lib.mkIf cfg.enable {
    users.users.ls.packages = with pkgs; [
      thunar
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };
}
