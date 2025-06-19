{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.nvim.plugins.lsp.nixd;
in
{
  options.pi.nvim.plugins.lsp.nixd = {
    enable = lib.mkEnableOption "nixd language server";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers.nixd = {
          enable = true;
        };
      };
    };
  };
}
