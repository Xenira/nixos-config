{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.dap.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.dap.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.dap = {
        enable = true;
        adapters.executables = {
          php = {
            command = "node";
            args = [ "os.getenv(\"HOME\") .. \"/repos/vscode-php-debug/out/phpDebug.js\"" ];
          };
        };
      };
    };
  };
}
