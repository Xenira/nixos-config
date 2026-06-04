{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust.tools.cargo-edit;
in
{
  options.pi.dev.lang.rust.tools.cargo-edit = {
    enable = lib.mkEnableOption "A utility for managing cargo dependencies from the command line.";
  };

  config = lib.mkIf cfg.enable {
    users.users.ls = {
      packages = with pkgs; [
        cargo-edit
      ];
    };
  };
}
