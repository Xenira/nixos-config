{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust.tools.bacon;
in
{
  options.pi.dev.lang.rust.tools.bacon = {
    enable = lib.mkEnableOption "Bacon";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.bacon = {
        # TODO: There is `bacon-ls`. Check if that is something I want.
        enable = true;
      };
    };
  };
}
