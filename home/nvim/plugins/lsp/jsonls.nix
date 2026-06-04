{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.nvim.plugins.lsp.jsonls;
in
{
  options.pi.nvim.plugins.lsp.jsonls = {
    enable = lib.mkEnableOption "jsonls language server";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins = {
        lsp.servers.jsonls = {
          enable = true;
        };
        schemastore.json = {
          enable = true;
        };
      };
    };
  };
}
