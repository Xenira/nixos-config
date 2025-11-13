{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.wilder.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.wilder.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.wilder = {
        enable = true;
        settings.modes = [
          ":"
          "/"
          "?"
        ];
      };
    };
  };
}
