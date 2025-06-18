{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.dev.direnv;
in
{
  options.pi.dev.direnv.enable = lib.mkEnableOption "Enable direnv configuration";

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
