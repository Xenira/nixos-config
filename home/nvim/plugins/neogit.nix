{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.neogit.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.neogit.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.neogit = {
        enable = true;
      };
    };
  };
}
