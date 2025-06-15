{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.lsp-signature.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.lsp-signature.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp-signature = {
        enable = true;
      };
    };
  };
}
