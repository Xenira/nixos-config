{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.dap-ui.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf (config.pi.nvim.plugins.dap-ui.enable && config.pi.nvim.plugins.dap.enable) {
    home-manager.users.ls = {
      programs.nixvim.plugins.dap-ui = {
        enable = true;
      };
    };
  };
}
