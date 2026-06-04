{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.nvim.plugins.lsp.qmlls.enable = lib.mkEnableOption "Enable qmlls LSP";

  config = lib.mkIf config.pi.nvim.plugins.lsp.qmlls.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers = {
          qmlls = {
            enable = true;
            settings = {
              importPaths =
                [ ]
                ++ lib.optionals config.pi.qs.enable [
                  "${pkgs.quickshell}/lib/qt-6/qml"
                ];
            };
          };
        };
      };
    };
  };
}
