{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.trouble.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.trouble.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.trouble = {
        enable = true;
      };
    };
  };
}
