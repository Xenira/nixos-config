{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.pi.nvim.plugins.lsp.perlnavigator;
in
{
  options.pi.nvim.plugins.lsp.perlnavigator = {
    enable = lib.mkEnableOption "perlnavigator language server";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers.perlnavigator = {
          enable = true;
        };
      };
    };
  };
}
