{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.rustaceanvim.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.rustaceanvim.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.rustaceanvim = {
        enable = true;
      };
    };
  };
}
