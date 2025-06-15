{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.which-key.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.which-key.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.which-key = {
        enable = true;
      };
    };
  };
}
