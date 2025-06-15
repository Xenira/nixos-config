{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.barbecue.enable = lib.mkEnableOption "Enable this plugin";

  config = lib.mkIf config.pi.nvim.plugins.barbecue.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.barbecue = {
        enable = true;
      };
    };
  };
}
