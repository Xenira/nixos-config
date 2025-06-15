{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.nvim-surround.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.nvim-surround.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.nvim-surround = {
        enable = true;
      };
    };
  };
}
