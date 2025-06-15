{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.gitblame.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.gitblame.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.gitblame = {
        enable = true;
        settings = {
          date_format = "%r";
        };
      };
    };
  };
}
