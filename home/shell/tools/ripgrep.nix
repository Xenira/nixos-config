{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.shell.tools.ripgrep;
in
{
  options.pi.shell.tools.ripgrep = {
    enable = lib.mkEnableOption "Enable ripgrep configuration";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs = {
        ripgrep.enable = true;
        ripgrep-all.enable = true;
      };
    };
  };
}
