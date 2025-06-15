{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.nvim.plugins.smear-cursor.enable = lib.mkEnableOption "Smear Cursor plugin for Neovim";

  config = lib.mkIf config.pi.nvim.plugins.smear-cursor.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.smear-cursor = {
        enable = true;
        settings = {
          delay_animation_start = 0;
          smear_between_neighbor_lines = false;
        };
      };
    };
  };
}
