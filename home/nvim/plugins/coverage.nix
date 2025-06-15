{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.coverage.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.coverage.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.coverage = {
        enable = true;
      };
    };
  };
}
