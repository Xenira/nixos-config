{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.pi.nvim.plugins.lsp.volar;
in
{
  options.pi.nvim.plugins.lsp.volar.enable = lib.mkEnableOption "Enable Volar LSP Plugin";

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers = {
          volar = {
            enable = true;
            tslsIntegration = config.pi.nvim.plugins.lsp.ts-ls.enable;
          };
        };
      };
    };
  };
}
