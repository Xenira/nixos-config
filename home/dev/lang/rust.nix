{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.dev.lang.rust;
in
{
  options.pi.dev.lang.rust = {
    enable = lib.mkEnableOption "Enable Rust development environment";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.ruff = {
        enable = true;
        settings = { };
      };
    };
  };
}
