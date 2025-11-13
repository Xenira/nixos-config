{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.diffview.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.diffview.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.diffview = {
        enable = true;
        settings = {
          view = {
            default.layout = "diff2_vertical";
            mergeTool.layout = "diff3_mixed";
          };
          filePanel.winConfig = {
            height = 20;
            position = "top";
          };
        };
      };
    };
  };
}
