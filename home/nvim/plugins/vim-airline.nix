{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins.vim-airline.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.vim-airline.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.airline = {
        enable = true;
      };
    };
  };
}
