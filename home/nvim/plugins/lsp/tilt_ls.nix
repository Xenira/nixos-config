{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.nvim.plugins.lsp.tilt_ls.enable = lib.mkEnableOption "Enable tilt_ls LSP";

  config = lib.mkIf config.pi.nvim.plugins.lsp.tilt_ls.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers = {
          tilt_ls = {
            enable = true;
          };
        };
      };
    };
  };
}
