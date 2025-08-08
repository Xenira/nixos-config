{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.nvim.plugins.lsp.sqls;
in
{
  options.pi.nvim.plugins.lsp.sqls = {
    enable = lib.mkEnableOption "SQLs language server";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp.servers.sqls = {
        enable = true;
      };
    };
  };
}
