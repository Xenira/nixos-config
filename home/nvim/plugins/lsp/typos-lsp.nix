{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.nvim.plugins.lsp.typos-lsp.enable = lib.mkEnableOption "Enable Typos LSP Plugin";

  config = lib.mkIf config.pi.nvim.plugins.lsp.typos-lsp.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers = {
          typos_lsp = {
            enable = true;
          };
        };
      };
    };
  };
}
