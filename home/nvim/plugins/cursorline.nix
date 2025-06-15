{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.cursorline.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.cursorline.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.cursorline = {
        enable = true;
      };
    };
  };
}
