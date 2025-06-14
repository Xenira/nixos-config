{ pkgs, lib, config, ... }:

{
  options.pi.nvim.plugins.lsp.volar.enable = lib.mkEnableOption "Enable Volar LSP Plugin";

  config = lib.mkIf config.pi.nvim.plugins.lsp.volar.enable {
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
