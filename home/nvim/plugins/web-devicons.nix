{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.web-devicons.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.web-devicons.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.web-devicons = {
        enable = true;
      };
    };
  };
}
