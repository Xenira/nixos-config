{
  pkgs,
  lib,
  config,
  ...
}:

let
  cfg = config.pi.nvim.plugins.lsp.rust-analyzer;
in
{
  options.pi.nvim.plugins.lsp.rust-analyzer.enable =
    lib.mkEnableOption "Enable TypeScript Language Server";

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers = {
          rust_analyzer = {
            enable = true;
            settings = {
              assist.emitMustUse = true;
              cargo.features = "all";
              diagnostics.styleLints.enable = true;
            };
          };
        };
      };
    };
  };
}
